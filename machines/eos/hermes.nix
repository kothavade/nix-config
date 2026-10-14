# Hermes Agent: a personal agent on the Claude Pro subscription, reachable over Discord.
# The model runs through the `claude` CLI via the DirectSDK plugin, so turns draw from the
# subscription's Agent SDK allowance rather than an API key.
#
# One-time setup on eos:
#   claude auth login
#   printf 'DISCORD_BOT_TOKEN=...\nDISCORD_ALLOWED_USERS=<your user id>\n' > ~/.config/hermes/secrets.env
#   chmod 600 ~/.config/hermes/secrets.env, then switch again to merge it into ~/.hermes/.env.
# Logs: ~/Library/Logs/hermes-agent{,.err}.log
{ inputs, user, ... }:
{
  # Hermes and claude-code come prebuilt from llm-agents.nix; upstream's flake has no cache and
  # building Hermes (Python deps plus the TUI/web frontends) on eos takes ages.
  nix.settings = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  home-manager.users.${user} =
    { config, pkgs, ... }:
    let
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
        # The plugin finds `claude` on the gateway's PATH. Shares the login (Keychain, ~/.claude)
        # with the homebrew cask that interactive shells use.
        extraPackages = [ llm.claude-code ];
        extraPlugins = [ claudeSubscription ];
        settings.model = {
          provider = "claude-subscription-directsdk-experimental";
          default = "sonnet";
        };
        environmentFiles = [ "${config.home.homeDirectory}/.config/hermes/secrets.env" ];
      };
    };
}
