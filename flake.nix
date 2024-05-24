{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Deduplicate Common Dependencies
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    flake-utils.url = "github:numtide/flake-utils";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
        pre-commit-hooks-nix.follows = "";
      };
    };
    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      user = "ved";
      overlays = [ inputs.zig.overlays.default ];
      mkSystem = import ./lib/mkSystem.nix { inherit overlays nixpkgs inputs; };
    in
    {
      darwinConfigurations.apollo = mkSystem "apollo" {
        inherit user;
        system = "aarch64-darwin";
        isDarwin = true;
      };
      nixosConfigurations.atlas = mkSystem "atlas" {
        inherit user;
        system = "x86_64-linux";
        # TODO: import modules instead
        secureBoot = true;
      };
      nixosConfigurations.hades = mkSystem "hades" {
        inherit user;
        system = "aarch64-linux";
        enableHM = false;
      };
    };
}
