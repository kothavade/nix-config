{
  nixpkgs,
  overlays,
  inputs,
}:
name:
{
  system,
  user,
  isDarwin ? false,
  enableHM ? true,
  secureBoot ? false,
}:
let
  machineConfig = ../machines/${name}.nix;
  osConfig = if isDarwin then ../modules/darwin else ../modules/nixos;
  sharedConfig = ../modules/shared;
  homeConfig = ../home;
  osHomeConfig = if isDarwin then ../home/darwin.nix else ../home/nixos.nix;
  osSystemFn = if isDarwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager =
    if isDarwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
in
osSystemFn {
  inherit system;
  specialArgs = {
    inherit inputs;
  };
  modules = [
    {
      nixpkgs.overlays = overlays;
      nix.registry.nixpkgs.flake = inputs.nixpkgs;
    }
    machineConfig
    osConfig
    sharedConfig
    (if secureBoot then inputs.lanzaboote.nixosModules.lanzaboote else { })
    (if enableHM then home-manager.home-manager else { })
    (
      if enableHM then
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user} = {
              imports = [
                homeConfig
                osHomeConfig
              ];
              home.stateVersion = "24.05";
            };
          };
        }
      else
        { }
    )
    (
      if (enableHM && isDarwin) then
        {
          home-manager.users.${user} = {
            imports = [ inputs.nix-index-database.hmModules.nix-index ];
          };
          users.users.${user} = {
            name = user;
            home = "/Users/${user}";
          };
        }
      else
        { }
    )
  ];
}
