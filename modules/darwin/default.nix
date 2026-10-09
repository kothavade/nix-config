{ pkgs, user, ... }:
{
  imports = [
    ./builders.nix
    ./homebrew.nix
    ./system.nix
  ];
  users.knownUsers = [ user ];
  users.users.${user} = {
    uid = 501;
    home = "/Users/${user}";
    shell = pkgs.fish;
  };
}
