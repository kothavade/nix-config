{ pkgs, flake, ... }:
let neovim = flake.inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
in {
  programs.neovim = {
    enable = true;
    package = neovim;
    defaultEditor = true;
    extraLuaPackages = luaPkgs: with luaPkgs; [ magick ];
  };
}
