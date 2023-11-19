_: {
  boot.loader.grub.device = "nodev";
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
  };
  system.stateVersion = "23.05";
}
