{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
    bitwarden-cli
    fastfetch
    gh
    nodejs
    ripgrep
    typst
    uv
  ];
}
