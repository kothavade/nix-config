{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    darwinLaunchOptions = ["--single-instance"];
    # TODO: this breaks on rebuild, but i don't like hardcoding either
    settings.shell = "${pkgs.fish}/bin/fish";
    # settings.shell = "/etc/profiles/per-user/ved/bin/fish";
    extraConfig = ''
      # base
      editor  nvim

      # font
      font_family       Liga SFMono Nerd Font
      bold_font         Liga SFMono Nerd Font Bold
      italic_font       Liga SFMono Nerd Font Italic
      bold_italic_font  Liga SFMono Nerd Font Bold Italic
      modify_font       underline_thickness 1
      modify_font       underline_position 18
      font_size         12.0
      disable_ligatures cursor

      # mac
      macos_option_as_alt                 yes
      macos_quit_when_last_window_closed  yes

      # hotkeys
      map   cmd+t             new_tab_with_cwd
      map   kitty_mod+t       new_tab_with_cwd
      map   kitty_mod+enter   launch --cwd=current --type=window
      map   cmd+enter         launch --cwd=current --type=window
      map   kitty_mod+e       kitten hints
      map   cmd+e             kitten hints

      # click on links to open
      mouse_map left click ungrabbed mouse_handle_click selection link prompt

      # ui
      tab_bar_style   powerline
      include         gruvbox.conf
    '';
  };
  home.file.".config/kitty/gruvbox.conf".source = ./gruvbox.conf;
}
