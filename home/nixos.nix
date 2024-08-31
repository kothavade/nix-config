{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.apple-cursor;
    name = "macOS-Monterey";
  };
  # Hyprland
  services = {
    wlsunset = {
      enable = true;
      latitude = 38.9869;
      longitude = -76.9426;
    };
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "off";
        preload = "~/Pictures/wallpaper-normal.png";
        wallpaper = [
          "DP-1,~/Pictures/wallpaper-normal.png"
          "HDMI-A-1,~/Pictures/wallpaper-normal.png"
        ];
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-dark-gtk;
      name = "gruvbox-dark";
    };
    iconTheme = {
      package = pkgs.gruvbox-dark-icons-gtk;
      name = "gruvbox-dark";
    };
    font = {
      name = "Inter";
      size = 11;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$pip" = "class:^(firefox)$, title:^(Firefox|Picture-in-Picture)$";
      cursor.no_hardware_cursors = true;
      exec-once = [ "waybar" ];
      monitor = "DP-1, 2560x1440@170, 0x0, 1";
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        layout = "dwindle";
      };
      decoration = {
        rounding = 0;
        blur = {
          enabled = false;
        };
        # TODO: colors
      };
      animations = {
        enabled = true;
        bezier = [
          "overshot,0.05,0.9,0.1,1.1"
          "overshot,0.13,0.99,0.29,1."
        ];
        # TODO: fix
        animation = [
          "windows,1,7,overshot,slide"
          "border,1,10,default"
          "fade,1,10,default"
          "workspaces,1,7,overshot,slidevert"
        ];
      };
      dwindle = {
        preserve_split = true;
      };
      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
      };
      input = {
        kb_layout = "us";
        accel_profile = "flat";
        follow_mouse = 1;
        sensitivity = 0.0;
      };
      windowrulev2 = [
        "float,$pip"
        "keepaspectratio,$pip"
        "suppressevent maximize, class:.*"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind =
        [
          "$mod SHIFT, ENTER, exec, firefox"
          "$mod, ENTER, exec, kitty -1"
          "$mod, Q, killactive"
          "$mod, N, movefocus, l"
          "$mod, E, movefocus, d"
          "$mod, I, movefocus, u"
          "$mod, O, movefocus, r"
          "$mod, SPACE, togglefloating"
          # TODO: move into config
          "$mod, R, exec, ~/.config/hypr/scripts/run.sh"
          "$mod, P, exec, ~/.config/hypr/scripts/power.sh"
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );
    };
  };
}
