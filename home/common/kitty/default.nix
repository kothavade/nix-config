{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    darwinLaunchOptions = ["--single-instance"];
    settings.shell = "${pkgs.fish}/bin/fish";
    extraConfig = ''
      font_family Liga  SFMono Nerd Font
      bold_font         Liga SFMono Nerd Font Bold
      italic_font Liga  SFMono Nerd Font Italic
      bold_italic_font  Liga SFMono Nerd Font Bold Italic
      modify_font       underline_thickness 1
      modify_font       underline_position 18

      disable_ligatures cursor

      font_size 12.0

      macos_option_as_alt yes
      macos_quit_when_last_window_closed yes

      map cmd+t new_tab_with_cwd
      map kitty_mod+t new_tab_with_cwd
      map kitty_mod+enter launch --cwd=current --type=window
      map cmd+enter       launch --cwd=current --type=window
      mouse_map left click ungrabbed mouse_handle_click selection link prompt
      map kitty_mod+e kitten hints
      map cmd+e kitten hints
      include gruvbox.conf
    '';
  };
  home.file.".config/kitty/gruvbox.conf".source = ./gruvbox.conf;
}
