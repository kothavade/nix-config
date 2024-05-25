{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      #- system
      gnumake
      #- tools
      devenv
      docker
      sccache
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
      gcc
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
      #-- golang
      go
      gopls
      gofumpt
    ]
    ++ (if pkgs.stdenv.isDarwin then [ ] else [ ]);
}
