{ flake, ... }: {
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
      extra-substituters = [ "https://nix-community.cachix.org" ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    overlays = [ flake.inputs.neovim-nightly-overlay.overlay ];
  };
  programs.fish.enable = true;
  programs.zsh.enable = true;
  services.nix-daemon.enable = true;
}
