_: {
  imports = [
    ./packages.nix
    ./git.nix
    ./direnv
    ./ghostty.nix
  ];
  programs.fish.shellInit = ''
    set -gx SSH_AUTH_SOCK $HOME/.bitwarden-ssh-agent.sock
    fish_add_path --path /opt/homebrew/bin $HOME/.local/bin
  '';
  # Deploys only add/remove casks; this upgrades them all. .pkg casks prompt for sudo.
  programs.fish.functions.upgrade = "brew update && brew upgrade --greedy";
}
