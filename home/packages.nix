{pkgs, ...}: let
  texpresso = pkgs.texpresso.overrideAttrs (oldAttrs: {
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.gcc];
  });
in {
  home.packages = with pkgs; [
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
    jujutsu
    awscli2
    qmk
    #- languages
    #-- sh
    shellcheck
    #-- js
    nodejs_20
    bun
    #-- c
    clang-tools
    #-- nix
    nil
    nix-output-monitor
    # nixfmt
    alejandra
    statix
    #-- lua
    lua-language-server
    #-- typst
    typst
    typst-lsp
    typst-preview
    #-- latex
    # tex
    texpresso
    texlab
    #-- python
    ruff-lsp
    #-- zig
    zig
    zls
    #-- golang
    go
    gopls
    gofumpt
  ];
}
