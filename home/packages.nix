{ pkgs, ... }:
let
  bemenuWayland = pkgs.bemenu.override { x11Support = false; };
in
{
  home.packages =
    with pkgs;
    [
      #- system
      gnumake
      #- tools
      yt-dlp
      wget
      htop
      fzf
      ripgrep
      fd
      bat
      fastfetch
      gh
      tree-sitter
      # imagemagick
      # websocat
      # awscli2 # FIXME: doesn't build
      #- languages
      #-- sh
      shellcheck
      #-- js
      nodejs_20
      # bun
      #-- c
      gcc # necessary?
      # clang-tools
      #-- nix
      nixd
      nixfmt-rfc-style
      statix
      #-- lua
      lua-language-server
      #-- typst
      # typst
      # typst-lsp
      # typst-preview
      #-- python
      ruff
      basedpyright
    ]
    ++ (
      if stdenv.isDarwin then
        # [ docker ]
        [ ]
      else
        [
          vial
          wl-clipboard
          waybar
          playerctl
          mako
          hyprpaper
          mpv
          pavucontrol
          bemenuWayland
          j4-dmenu-desktop
          zip
          unzip
          wlsunset
          zed-editor
          brave
        ]
    );
}
