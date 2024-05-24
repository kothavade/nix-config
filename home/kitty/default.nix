{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    darwinLaunchOptions = [ "--single-instance" ];
    settings.shell = "/etc/profiles/per-user/ved/bin/fish";
    extraConfig =
      ''
        # base
        editor  nvim

        # font
        font_family       Berkeley Mono
        symbol_map        U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d4,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f532,U+f0001-U+f1af0 Symbols Nerd Font Mono
        symbol_map        U+279c Arial Unicode MS
        modify_font       underline_thickness 1
        modify_font       underline_position 18
        disable_ligatures cursor

        # mac
        macos_option_as_alt                 yes
        macos_quit_when_last_window_closed  yes

        # hotkeys
        map   cmd+t             new_tab_with_cwd
        map   ctrl+t            new_tab_with_cwd
        map   cmd+l             next_layout
        map   ctrl+l            next_layout
        map   kitty_mod+l       next_layout
        map   kitty_mod+t       new_tab_with_cwd
        map   ctrl+t            new_tab_with_cwd
        map   kitty_mod+enter   launch --cwd=current --type=window
        map   ctrl+enter        launch --cwd=current --type=window
        map   cmd+enter         launch --cwd=current --type=window
        map   kitty_mod+e       kitten hints
        map   ctrl+e            kitten hints
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
      ''
      + (
        if pkgs.stdenv.isDarwin then
          ''
            font_size 12.0
          ''
        else
          ''
            font_size 11.0
          ''
      );
  };
  home.file.".config/kitty/gruvbox.conf".source = ./gruvbox.conf;
}
