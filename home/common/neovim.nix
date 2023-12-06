_: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaPackages = luaPkgs: with luaPkgs; [ magick ];
  };
}
