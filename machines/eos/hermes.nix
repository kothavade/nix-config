# Hermes Agent: a personal agent on the Claude Pro subscription, reachable over Discord.
# The model runs through the `claude` CLI via the DirectSDK plugin, so turns draw from the
# subscription's Agent SDK allowance rather than an API key.
#
# Discord credentials live in secrets/hermes.env.age (DISCORD_BOT_TOKEN, DISCORD_ALLOWED_USERS),
# which agenix decrypts straight to ~/.hermes/.env. One-time setup on eos: `claude auth login`.
# Logs: ~/Library/Logs/hermes-agent{,.err}.log
{ inputs, user, ... }:
let
  gateway = "org.nix-community.home.hermes-agent";
in
{
  age.secrets.hermes-env = {
    file = ../../secrets/hermes.env.age;
    path = "/Users/${user}/.hermes/.env";
    owner = user;
    mode = "0400";
  };

  home-manager.users.${user} =
    {
      config,
      osConfig,
      pkgs,
      ...
    }:
    let
      # Prebuilt on llm-agents.nix's cache (configured in modules/darwin/system.nix); upstream's
      # flake has no cache, and building Hermes and its frontends on eos takes ages.
      llm = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
      # Upstream's module (used for its launchd agent and config handling) expects upstream's
      # package, which carries `hermesVenv`: a python that can import hermes, used to stamp the
      # config version. Point it at llm-agents' python env; `//` keeps the cached store path.
      hermes = llm.hermes-agent // {
        hermesVenv = pkgs.writeShellScriptBin "python3" ''
          py=$(grep -o '/nix/store/[^ ]*-env/bin/python3' ${llm.hermes-agent}/bin/hermes | head -1)
          PYTHONPATH=$(echo ${llm.hermes-agent}/lib/python3*/site-packages) exec "$py" "$@"
        '';
      };
      # A flake input rather than a pinned fetch, so the lock bot bumps it alongside Hermes and
      # the two stay in step. extraPlugins wants plugin.yaml at the package root.
      claudeSubscription = pkgs.runCommand "claude-subscription-directsdk" { } ''
        cp -r ${inputs.hermes-official-plugins}/claude-subscription-directsdk $out
      '';
    in
    {
      imports = [ inputs.hermes-agent.homeManagerModules.default ];

      programs.hermes-agent.enable = true;
      services.hermes-agent = {
        enable = true;
        gateway.enable = true;
        package = hermes;
        # The plugin finds `claude` on the gateway's PATH (the launchd agent doesn't see
        # home.packages). Same package and login as the interactive `claude`.
        extraPackages = [
          llm.claude-code
          llm.agent-browser
        ];
        extraPlugins = [ claudeSubscription ];
        settings.model = {
          provider = "claude-subscription-directsdk-experimental";
          default = "sonnet";
        };
        # Never prompt for command approval (this is a single-user box behind a Discord allowlist).
        settings.approvals = {
          mode = "off";
          cron_mode = "approve";
          single_query_mode = "approve";
          unattended_mode = "approve";
        };
        # Skills hidden from the prompt index to cut context bloat (files stay on disk; remove a
        # name here to re-enable it).
        settings.skills.disabled = [
          # mlops
          "dspy"
          "huggingface-hub"
          "fine-tuning-with-trl"
          "grpo-rl-training"
          "peft-fine-tuning"
          "axolotl"
          "pytorch-fsdp"
          "unsloth"
          "audiocraft-audio-generation"
          "segment-anything-model"
          "clip"
          "stable-diffusion-image-generation"
          "whisper"
          "modal-serverless-gpu"
          "guidance"
          "gguf-quantization"
          "serving-llms-vllm"
          "obliteratus"
          "llama-cpp"
          "outlines"
          "evaluating-llms-harness"
          "weights-and-biases"
          # gaming, red-teaming, smart-home
          "minecraft-modpack-server"
          "pokemon-player"
          "godmode"
          "openhue"
          # creative
          "ascii-art"
          "ascii-video"
          "baoyu-infographic"
          "ideation"
          "manim-video"
          "p5js"
          "popular-web-designs"
          "songwriting-and-ai-music"
          # niche productivity
          "telegov-appointment-booking"
          "teams-meeting-pipeline"
          "airtable"
          "box"
          # X/Twitter
          "xitter"
          "xurl"
          # apple, agent CLIs, creative, data/devops/mcp, email
          "findmy"
          "codex"
          "opencode"
          "architecture-diagram"
          "claude-design"
          "design-md"
          "excalidraw"
          "humanizer"
          "jupyter-live-kernel"
          "mcporter"
          "native-mcp"
          "himalaya"
          # github (keep only `github`), media
          "github-auth"
          "github-code-review"
          "github-issues"
          "github-pr-workflow"
          "github-repo-management"
          "gif-search"
          "heartmula"
          "songsee"
          "youtube-content"
          "find-nearby"
          "obsidian"
          # productivity (keep google-workspace, pdf, maps, ocr-and-documents)
          "linear"
          "notion"
          "docx"
          "xlsx"
          "powerpoint"
          "nano-pdf"
          "document-to-action-items"
          "meeting-action-items"
          "weekly-review-planning"
          "product-price-monitor"
          # research
          "arxiv"
          "blogwatcher"
          "competitor-news-monitor"
          "grounded-citations"
          "llm-wiki"
          "polymarket"
          "research-paper-writing"
          # software-development (keep plan, systematic-debugging)
          "test-driven-development"
          "writing-plans"
          "subagent-driven-development"
          "requesting-code-review"
          "simplify-code"
          "spike"
          "codebase-inspection"
          "dogfood"
          "python-debugpy"
          "node-inspect-debugger"
          "hermes-agent-skill-authoring"
          "inspecting-hermes-desktop-dom"
          "sdlc-review"
        ];
        # Reply in the #hermes channel without needing an @mention.
        settings.discord.free_response_channels = "1559776715633332235";
        # ...and open a thread per top-level message there, so each task gets its own session.
        settings.discord.free_response_auto_thread = true;
        # Where cron output and notifications go; silences the "no home channel" notice.
        settings.platforms.discord.home_channel = {
          platform = "discord";
          chat_id = "1559779425258577961";
          name = "Home";
        };
        # Webhook listener for event-driven runs (Gmail push triage). Loopback only; each route
        # carries its own HMAC secret in ~/.hermes/webhook_subscriptions.json (`hermes webhook
        # subscribe`), so no secret lives here. Exposed publicly only via the relay below.
        settings.platforms.webhook = {
          enabled = true;
          extra = {
            host = "127.0.0.1";
            port = 8644;
          };
        };
      };

      # Gmail push relay: Pub/Sub can't HMAC-sign, so this takes its POSTs (exposed through the
      # Tailscale Funnel agent below), checks the URL token and forwards signed events to the
      # Hermes webhook route `gmail-triage`. Read-only. Config and state live in
      # ~/.hermes/gmail-relay*.json.
      launchd.agents.gmail-relay = {
        enable = true;
        config = {
          ProgramArguments = [
            "${pkgs.python3}/bin/python3"
            "-I"
            "${./gmail-relay.py}"
          ];
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "${config.home.homeDirectory}/Library/Logs/gmail-relay.log";
          StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/gmail-relay.err";
        };
      };

      # Public HTTPS for the relay: https://eos.<tailnet>.ts.net/gmail/... -> 127.0.0.1:8645. Run in
      # the foreground so the Funnel exists exactly as long as this agent does (launchd restarts
      # it); nothing else on eos is exposed. Needs the user to be tailscaled's operator
      # (`sudo tailscale set --operator=${user}`, once).
      launchd.agents.gmail-funnel = {
        enable = true;
        config = {
          ProgramArguments = [
            "/run/current-system/sw/bin/tailscale"
            "funnel"
            "--set-path=/gmail"
            "http://127.0.0.1:8645/gmail"
          ];
          RunAtLoad = true;
          KeepAlive = true;
          ThrottleInterval = 30;
          StandardOutPath = "${config.home.homeDirectory}/Library/Logs/gmail-funnel.log";
          StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/gmail-funnel.err";
        };
      };

      # llm-agents' build omits the locale catalogs, so every user-facing string (progress lines,
      # approval prompts) rendered as its raw key. Use the ones from upstream's source tree, which
      # the same flake input pins to a release close to the packaged version.
      launchd.agents.hermes-agent.config.EnvironmentVariables.HERMES_BUNDLED_LOCALES =
        "${inputs.hermes-agent}/locales";

      # Let the gateway's shell (git signing, ssh pushes) use the Bitwarden SSH agent, as fish does.
      launchd.agents.hermes-agent.config.EnvironmentVariables.SSH_AUTH_SOCK =
        "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";

      # Browser tools: agent-browser (on the gateway PATH above) drives nixpkgs' Chrome instead of
      # the Playwright Chromium that `hermes pm install` would fetch, which nix can't manage.
      launchd.agents.hermes-agent.config.EnvironmentVariables.AGENT_BROWSER_EXECUTABLE_PATH =
        "${pkgs.google-chrome}/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";

      # agenix decrypts from a launchd daemon, asynchronously to activation and at boot, while
      # the gateway reads .env only at start. Restart it whenever /run/agenix points at a new
      # generation. Polled (plus RunAtLoad and a WatchPaths fast path) because this agent can
      # load after agenix already swapped the link, which a watch alone misses.
      launchd.agents.hermes-agent-secrets = {
        enable = true;
        config = {
          ProgramArguments = [
            "${pkgs.writeShellScript "hermes-agent-secrets" ''
              state=${config.home.homeDirectory}/.hermes/.secrets-generation
              current=$(readlink /run/agenix) || exit 0
              [ "$current" = "$(cat "$state" 2>/dev/null)" ] && exit 0
              /bin/launchctl kickstart -k gui/${toString osConfig.users.users.${user}.uid}/${gateway}
              echo "$current" >"$state"
            ''}"
          ];
          RunAtLoad = true;
          StartInterval = 60;
          WatchPaths = [ "/run/agenix" ];
        };
      };
    };
}
