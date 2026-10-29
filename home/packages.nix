{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex
    bitwarden-cli
    fastfetch
    gh
    nodejs
    ripgrep
    typst
    uv
  ];
}
