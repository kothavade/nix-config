{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      darwin,
      home-manager,
      nix-index-database,
      ...
    }@inputs:
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
      };
      nixosConfigurations.hades = mkSystem "hades" {
        inherit user;
        system = "aarch64-linux";
        enableHM = false;
      };
    };
}
