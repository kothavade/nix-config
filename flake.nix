{
  outputs =
    { nixpkgs, ... }@inputs:
    let
      user = "ved";
      overlays = [ ];
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

      templates = {
        rust = {
          path = ./templates/rust;
          description = "Rust dev env with Fenix";
        };
      };
    };

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

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
    # flake-utils.url = "github:numtide/flake-utils";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
        pre-commit-hooks-nix.follows = "";
      };
    };
  };
}
