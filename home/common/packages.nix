{ pkgs, ... }: {
  home.packages = with pkgs; [
    # tools
    docker
    sccache
    yt-dlp
    wget
    htop
    fzf
    ripgrep
    fd
    bat
    delta
    fastfetch
    gh
    github-copilot-cli
    tree-sitter
    imagemagick
    flyctl
    awscli2
    # languages
    typst
    nodejs_20
    bun
    deno
    clang-tools
    nil
    nixfmt
    statix
    lua-language-server
  ];
}
