{ pkgs, flake, ... }:
let
  # master = flake.inputs.nixpkgs-master.legacyPackages.${pkgs.system};
  stable = flake.inputs.nixpkgs-stable.legacyPackages.${pkgs.system};
in {
  home.packages = with pkgs;
    [
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
      # flyctl
      # awscli2
      obsidian
      websocat
      # languages
      nodejs_20
      bun
      deno
      clang-tools
      nil
      nixfmt
      statix
      lua-language-server
      typst
      typst-preview
      nodePackages.pyright
      ruff-lsp
    ] ++ [ stable.typst-lsp ];
}
