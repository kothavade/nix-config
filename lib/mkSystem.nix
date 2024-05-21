{
  nixpkgs,
  overlays,
  inputs,
}: name: {
  system,
  user,
  isDarwin ? false,
  enableHM ? true,
}: let
  machineConfig = ../machines/${name}.nix;
  osConfig =
    if isDarwin
    then ../modules/darwin
    else ../modules/nixos;
  sharedConfig = ../modules/shared;
  homeConfig = ../home;
  # osHomeConfig = ../home/darwin.nix;
  osHomeConfig =
    if isDarwin
    then ../home/darwin.nix
    else ../home/nixos.nix;
  osSystemFn =
    if isDarwin
    then inputs.darwin.lib.darwinSystem
    else nixpkgs.lib.nixosSystem;
  home-manager =
    if isDarwin
    then inputs.home-manager.darwinModules
    else inputs.home-manager.nixosModules;
in
  osSystemFn {
    inherit system;
    specialArgs = inputs;
    modules = [
      {nixpkgs.overlays = overlays;}
      machineConfig
      osConfig
      sharedConfig
      (
        if enableHM
        then home-manager.home-manager
        else {}
      )
      (
        if enableHM
        then {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = {
            imports = [
              homeConfig
              osHomeConfig
              inputs.nix-index-database.hmModules.nix-index
            ];
            home.stateVersion = "24.05";
          };
        }
        else {}
      )
      (
        if (enableHM && isDarwin)
        then {
          users.users.${user} = {
            name = user;
            home = "/Users/${user}";
          };
        }
        else {}
      )
    ];
  }
