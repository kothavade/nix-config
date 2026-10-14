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
        extraPackages = [ llm.claude-code ];
        extraPlugins = [ claudeSubscription ];
        settings.model = {
          provider = "claude-subscription-directsdk-experimental";
          default = "sonnet";
        };
      };

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
