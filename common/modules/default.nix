{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ discord ];
  nix = {
    extraOptions = ''
      auto-optimise-store = true
      extra-nix-path = nixpkgs=flake:nixpkgs
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      autoOptimiseStore = true;
    };
  };

  services.nix-daemon.enable = true;
}
