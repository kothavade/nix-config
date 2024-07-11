_: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  home.file.".config/nvim" = {
    recursive = true;
    source = ./nvim;
  };
}
