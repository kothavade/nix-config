{ pkgs, user, ... }:
{
  imports = [
    ./builders.nix
    ./comin.nix
    ./homebrew.nix
    ./system.nix
  ];
  users.knownUsers = [ user ];
  users.users.${user} = {
    uid = 501;
    home = "/Users/${user}";
    shell = pkgs.fish;
    # For plain (non-Tailscale) SSH, e.g. eos.local over the LAN.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJOAm1RLAlDnqjZeSuABKIpRERsIsWxJvtWh8YIPE8iU bw"
    ];
  };
}
