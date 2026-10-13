# Hermes Agent: a personal agent on the Claude Pro subscription, reachable over Discord.
# The model runs through the `claude` CLI (homebrew cask) via the DirectSDK plugin, so turns
# draw from the subscription's Agent SDK allowance rather than an API key.
#
# One-time setup on eos:
#   claude auth login
#   printf 'DISCORD_BOT_TOKEN=...\nDISCORD_ALLOWED_USERS=<your user id>\n' > ~/.config/hermes/secrets.env
#   chmod 600 ~/.config/hermes/secrets.env, then switch again to merge it into ~/.hermes/.env.
# Logs: ~/Library/Logs/hermes-agent{,.err}.log
{ inputs, user, ... }:
{
  home-manager.users.${user} =
    { config, pkgs, ... }:
    let
      # A flake input rather than a pinned fetch, so the lock bot bumps it alongside hermes-agent
      # and the two stay in step. extraPlugins wants plugin.yaml at the package root.
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
        # Core + discord.py; the default package also builds voice, TTS, cloud sandboxes, etc.
        package = inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.messaging;
        extraPlugins = [ claudeSubscription ];
        settings.model = {
          provider = "claude-subscription-directsdk-experimental";
          default = "sonnet";
        };
        environmentFiles = [ "${config.home.homeDirectory}/.config/hermes/secrets.env" ];
      };
    };
}
