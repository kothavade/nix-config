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
      # The 1 MiB default stalls large substitutions ("download buffer is full").
      download-buffer-size = 268435456;
      http-connections = 64;
    };
    extraOptions = ''
      extra-nix-path = nixpkgs=flake:nixpkgs
    '';
    optimise.automatic = true;
  };
  nixpkgs.config.allowUnfree = true;
  programs.fish.enable = true;
}
