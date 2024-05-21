{
  pkgs,
  lib,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "virtio_scsi"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/212cd5a1-2932-4462-b038-c3035bb2fbd7";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D0B5-45BB";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [
    # Needed when not using Home Manager
    vim
    git
    gnumake
  ];

  networking.hostName = "hades";

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9SDEnJI+ueh1lXbrTpG2hoHtc6RfjRxd0RTXjjDdkB ved@kothavade.com"
  ];

  services.tailscale.useRoutingFeatures = "server";

  users.users.ved = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
