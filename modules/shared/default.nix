_: {
  nix = {
    settings = {
      trusted-users = [
        "root"
        "ved"
      ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    extraOptions = ''
      extra-nix-path = nixpkgs=flake:nixpkgs
    '';
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  programs.fish.enable = true;
  programs.zsh.enable = true;
}
