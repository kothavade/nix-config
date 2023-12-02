{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.inputs.flake-parts.follows = "flake-parts";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      imports = [ inputs.nixos-flake.flakeModule ./overlays ];
      flake = let userName = "ved";
      in {
        nixosConfigurations = {
          hades = self.nixos-flake.lib.mkLinuxSystem {
            nixpkgs.hostPlatform = "x86_64-linux";
            imports = [
              { users.users.${userName}.isNormalUser = true; }
              ./modules/common
              ./modules/linux
              self.nixosModules.home-manager
              {
                home-manager.users.${userName} = {
                  imports = [ ./home/common ./home/linux ];
                  home.stateVersion = "23.05";
                };
              }
            ];
          };
        };

        darwinConfigurations = {
          apollo = self.nixos-flake.lib.mkMacosSystem {
            nixpkgs.hostPlatform = "aarch64-darwin";
            imports = [
              ./modules/common
              ./modules/darwin
              self.darwinModules_.home-manager
              {
                users.users.${userName} = {
                  name = userName;
                  home = "/Users/${userName}";
                };
                home-manager.users.${userName} = {
                  imports = [ ./home/common ./home/darwin ];
                  home.stateVersion = "23.05";
                };
              }
            ];
          };
        };
      };

      perSystem = { self', system, pkgs, lib, config, inputs', ... }: {
        nixos-flake.primary-inputs =
          [ "nixpkgs" "home-manager" "nix-darwin" "nixos-flake" ];
        packages.default = self'.packages.activate;
        _module.args = {
          nixpkgs.overlays = lib.mkForce [ self.overlays.default ];
        };
      };
    };
}

