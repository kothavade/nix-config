_: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    extraLuaPackages = ps: [ ps.magick ];
  };
}
