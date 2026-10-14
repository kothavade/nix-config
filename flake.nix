{
  outputs =
    { nixpkgs, ... }@inputs:
    let
      user = "ved";
      mkSystem = import ./lib/mkSystem.nix { inherit nixpkgs inputs; };
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs [ "aarch64-darwin" "aarch64-linux" ] (
          system: f nixpkgs.legacyPackages.${system}
        );
    in
    {
      darwinConfigurations.apollo = mkSystem "apollo" {
        inherit user;
        system = "aarch64-darwin";
        isDarwin = true;
        machine = ./machines/apollo.nix;
        homeStateVersion = "24.05";
      };
      darwinConfigurations.eos = mkSystem "eos" {
        inherit user;
        system = "aarch64-darwin";
        isDarwin = true;
        machine = ./machines/eos;
        homeStateVersion = "26.05";
      };
      nixosConfigurations.eris = mkSystem "eris" {
        inherit user;
        system = "aarch64-linux";
        machine = ./machines/eris;
        homeStateVersion = "26.05";
      };

      formatter = forAllSystems (pkgs: pkgs.nixfmt-tree);
      # direnv loads this via .envrc; it points git at the tracked hooks in .githooks.
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [ pkgs.nixfmt ];
          shellHook = "git config core.hooksPath .githooks";
        };
      });
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    comin.url = "github:nlewo/comin";
    comin.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    hermes-agent.url = "github:NousResearch/hermes-agent";
    hermes-agent.inputs.nixpkgs.follows = "nixpkgs";
    hermes-agent.inputs.home-manager.follows = "home-manager";
    # Not following nixpkgs: its binary cache only hits for its own pinned nixpkgs.
    llm-agents.url = "github:numtide/llm-agents.nix";
    hermes-official-plugins.url = "github:NousResearch/hermes-official-plugins";
    hermes-official-plugins.flake = false;
    no-clown-fiesta-ghostty.url = "github:no-clown-fiesta/no-clown-fiesta.ghostty";
    no-clown-fiesta-ghostty.flake = false;
  };
}
