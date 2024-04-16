{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    defaultEditor = true;
    extraLuaPackages = luaPkgs: with luaPkgs; [magick];
  };
}
