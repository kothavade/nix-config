{pkgs, ...}: {
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
    #- languages
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
