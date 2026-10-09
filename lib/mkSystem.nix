{
  nixpkgs,
  inputs,
}:
name:
{
  system,
  user,
  machine,
  homeStateVersion,
  isDarwin ? false,
}:
let
  osSystemFn = if isDarwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager =
    if isDarwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
  comin = if isDarwin then inputs.comin.darwinModules else inputs.comin.nixosModules;
in
osSystemFn {
  specialArgs = {
    inherit inputs user;
  };
  modules = [
    {
      nixpkgs.hostPlatform = system;
      nix.registry.nixpkgs.flake = inputs.nixpkgs;
      networking.hostName = name;
    }
    machine
    (if isDarwin then ../modules/darwin else ../modules/nixos)
    ../modules/shared
    comin.comin
    home-manager.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        # Move aside unmanaged dotfiles instead of refusing to switch.
        backupFileExtension = "hm-bak";
        users.${user} = {
          imports = [ ../home ] ++ nixpkgs.lib.optional isDarwin ../home/darwin.nix;
          home.stateVersion = homeStateVersion;
        };
      };
    }
  ];
}
