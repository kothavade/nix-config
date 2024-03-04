{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    darwinLaunchOptions = [ "--single-instance" ];
    settings.shell = "${pkgs.fish}/bin/fish";
    extraConfig = ''
      font_family Liga SFMono Nerd Font
      bold_font Liga SFMono Nerd Font Bold
      italic_font Liga SFMono Nerd Font Italic
      bold_italic_font Liga SFMono Nerd Font Bold Italic
      modify_font      underline_thickness 1
      modify_font      underline_position 18

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

      foreground                      #B4BDC3
      background                      #1C1917
      selection_foreground            #B4BDC3
      selection_background            #3D4042
      cursor                          #C4CACF
      cursor_text_color               #1C1917
      active_tab_foreground           #B4BDC3
      active_tab_background           #65435E
      inactive_tab_foreground         #B4BDC3
      inactive_tab_background         #352F2D
      color0 #1C1917
      color8 #403833
      color1 #DE6E7C
      color9 #E8838F
      color2  #819B69
      color10 #8BAE68
      color3  #B77E64
      color11 #D68C67
      color4  #6099C0
      color12 #61ABDA
      color5  #B279A7
      color13 #CF86C1
      color6  #66A5AD
      color14 #65B8C1
      color7  #B4BDC3
      color15 #888F94


      # foreground #dde1e6
      # background #161616
      # selection_foreground #f2f4f8
      # selection_background #525252

      # cursor #f2f4f8
      # cursor_text_color #393939

      # url_color #ee5396
      # url_style single

      # active_border_color #ee5396
      # inactive_border_color #ff7eb6

      # bell_border_color #ee5396

      # wayland_titlebar_color system
      # macos_titlebar_color system

      # active_tab_foreground #161616
      # active_tab_background #ee5396
      # inactive_tab_foreground #dde1e6
      # inactive_tab_background #393939
      # tab_bar_background #161616

      #color0 #262626
      #color8 #393939

      #color1 #ff7eb6
      #color9 #ff7eb6

      #color2  #42be65
      #color10 #42be65

      #color3  #82cfff
      #color11 #82cfff

      #color4  #33b1ff
      #color12 #33b1ff

      #color5  #ee5396
      #color13 #ee5396

      #color6  #3ddbd9
      #color14 #3ddbd9

      #color7  #dde1e6
      #color15 #ffffff
    '';
  };
}
