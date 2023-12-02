_: {
  flake.overlays.default = final: prev: {
    otf-apple = prev.callPackage ./derivations/otf-apple.nix { };
    sf-mono-liga-bin = prev.callPackage ./derivations/sf-mono-liga-bin.nix { };
  };
}
