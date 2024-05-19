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

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    nix-index-database,
    ...
  } @ inputs: let
    user = "ved";
  in {
    darwinConfigurations.apollo = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = inputs;
      modules = [
        ./modules/common
        ./modules/darwin
        home-manager.darwinModules.home-manager
        {
          users.users.${user} = {
            name = user;
            home = "/Users/${user}";
          };
          home-manager.users.${user} = {
            imports = [
              ./home
              ./home/darwin.nix
              nix-index-database.hmModules.nix-index
            ];
            home.stateVersion = "24.05";
          };
        }
      ];
    };

    nixosConfigurations.hades = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = inputs;
      modules = [
        {
          users.users.${user} = {
            isNormalUser = true;
            extraGroups = ["wheel"];
          };
        }
        ./modules/common
        ./modules/hades
      ];
    };
  };
}
