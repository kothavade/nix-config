{
  description = "A Rust Project";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
  };
  outputs = { self, nixpkgs, rust-overlay, }:
    let
      allSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      forAllSystems = f:
        nixpkgs.lib.genAttrs allSystems (system:
          let
            overlays = [ (import rust-overlay) ];
            pkgs = import nixpkgs { inherit system overlays; };
            rust-stable = pkgs.rust-bin.stable.latest.default;
            buildInputs = [
              (rust-stable.override {
                extensions = [ "rust-src" "rust-analyzer" ];
              })
            ];
          in f {
            pkgs = pkgs;
            buildInputs = buildInputs;
          });
    in {
      devShells = forAllSystems ({ pkgs, buildInputs, }: {
        default = pkgs.mkShell { inherit buildInputs; };
      });
    };
}
