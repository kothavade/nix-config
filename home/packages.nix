{ pkgs, ... }:
let
  bemenu = pkgs.bemenu.override { x11Support = false; };
  prismlauncher = pkgs.prismlauncher.override { withWaylandGLFW = true; };
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
      imagemagick
      websocat
      bitwarden-cli
      awscli2
      vial
      #- languages
      #-- sh
      shellcheck
      #-- js
      nodejs_20
      bun
      #-- c
      gcc # necessary?
      clang-tools
      #-- nix
      nil
      nixfmt-rfc-style
      statix
      #-- lua
      lua-language-server
      #-- typst
      typst
      typst-lsp
      typst-preview
      #-- python
      ruff-lsp
      #-- zig
      zigpkgs.master-2024-05-05 # std.zip merged
      zls
    ]
    ++ (
      if pkgs.stdenv.isDarwin then
        [ docker ]
      else
        [
          wl-clipboard
          waybar
          playerctl
          mako
          hyprpaper
          mpv
          pavucontrol
          bemenu
          j4-dmenu-desktop
          zip
          unzip
          wlsunset
          prismlauncher
        ]
    );
}
