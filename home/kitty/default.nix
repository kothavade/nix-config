_: {
  programs.kitty = {
    enable = true;
    darwinLaunchOptions = ["--single-instance"];
    settings.shell = "/etc/profiles/per-user/ved/bin/fish";
    extraConfig = ''
      # base
      editor  nvim

      # font
      font_family       Berkeley Mono
      symbol_map        U+279c Arial Unicode MS
      modify_font       underline_thickness 1
      modify_font       underline_position 18
      font_size         12.0
      disable_ligatures cursor

      # mac
      macos_option_as_alt                 yes
      macos_quit_when_last_window_closed  yes

      # hotkeys
      map   cmd+t             new_tab_with_cwd
      map   cmd+l             next_layout
      map   kitty_mod+l             next_layout
      map   kitty_mod+t       new_tab_with_cwd
      map   kitty_mod+enter   launch --cwd=current --type=window
      map   cmd+enter         launch --cwd=current --type=window
      map   kitty_mod+e       kitten hints
      map   cmd+e             kitten hints

      # click on links to open
      mouse_map left click ungrabbed mouse_handle_click selection link prompt

      # ui
      tab_bar_style           powerline
      active_tab_foreground   #ebdbb2
      active_tab_background   #504945
      inactive_tab_foreground #ebdbb2
      inactive_tab_background #3c3836
      include                 gruvbox.conf
    '';
  };
  home.file.".config/kitty/gruvbox.conf".source = ./gruvbox.conf;
}
