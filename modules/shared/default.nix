_: {
  nix = {
    settings.trusted-users = ["root" "ved"];
    extraOptions = ''
      auto-optimise-store = true
      extra-nix-path = nixpkgs=flake:nixpkgs
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      autoOptimiseStore = true;
      extra-substituters = ["https://nix-community.cachix.org"];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  programs.fish.enable = true;
  programs.zsh.enable = true;
}
