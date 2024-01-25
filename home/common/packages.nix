{ pkgs, ... }:
# let
# master = flake.inputs.nixpkgs-master.legacyPackages.${pkgs.system};
# stable = flake.inputs.nixpkgs-stable.legacyPackages.${pkgs.system};
# in {
{
  home.packages = with pkgs; [
    #- tools
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
    tree-sitter
    imagemagick
    obsidian
    websocat
    bitwarden-cli
    #- languages
    #-- js
    nodejs_20
    bun
    deno
    #-- c
    clang-tools
    #-- nix
    nil
    nixfmt
    statix
    #-- lua
    lua-language-server
    #-- typst
    typst
    typst-lsp
    typst-preview
    #-- python
    nodePackages.pyright
    ruff-lsp
    #-- zig
    zig
    zls
  ];
}
