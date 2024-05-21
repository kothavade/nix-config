_: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaPackages = luaPkgs: with luaPkgs; [ magick ];
  };
  home.file.".config/nvim" = {
    recursive = true;
    source = ./nvim;
  };
}
