{ user, ... }:
{
  imports = [ ./comin.nix ];

  nix = {
    settings = {
      trusted-users = [
        "root"
        user
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    extraOptions = ''
      extra-nix-path = nixpkgs=flake:nixpkgs
    '';
    optimise.automatic = true;
  };
  nixpkgs.config.allowUnfree = true;
  programs.fish.enable = true;
}
