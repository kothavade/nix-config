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
}
