{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bitwarden-cli
    fastfetch
    gh
    nodejs
    ripgrep
    typst
    uv
  ];
}
