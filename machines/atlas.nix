{
  config,
  lib,
  pkgs,
  ...
}:
{
  hardware.enableRedistributableFirmware = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];

    # Bootloader.
    loader.systemd-boot.enable = lib.mkForce false;
    loader.efi.canTouchEfiVariables = true;

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b386e156-a293-4394-913b-74952a5f6298";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6951-457B";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];
  networking = {
    hostName = "atlas";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    # NextDNS
    nameservers = [
      "45.90.28.0#499645.dns.nextdns.io"
      "2a07:a8c0::#499645.dns.nextdns.io"
      "45.90.30.0#499645.dns.nextdns.io"
      "2a07:a8c1::#499645.dns.nextdns.io"
    ];
  };

  # Fixes Windows Dual Boot time
  time.hardwareClockInLocalTime = true;

  services = {
    resolved = {
      enable = true;
      domains = [ "~." ];
      dnsovertls = "true";
    };

    tailscale.useRoutingFeatures = "both";

    # Plasma 6
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;

    xserver = {
      # Load nvidia driver for Xorg and Wayland
      videoDrivers = [ "nvidia" ];

      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # Enable CUPS to print documents.
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    udev.packages = [ pkgs.vial ];
  };

  hardware = {
    cpu.amd.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [ pkgs.nvidia-vaapi-driver ];
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      # TODO: is there a better option? (beta, production)
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      # TODO: nvidia-persistanced?
    };
    pulseaudio.enable = false;
  };

  environment.variables = {
    LIBDA_DRIVER_NAME = "nvidia";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    NVD_BACKEND = "direct";
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;

  # TODO: users in mkSystem instead
  users.users.ved = {
    isNormalUser = true;
    description = "Ved Kothavade";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      plasma5Packages.polonium
      kdePackages.plasma-browser-integration
      haruna
      wl-clipboard
      wayland-utils
    ];
  };

  programs.firefox.enable = true;

  fonts.packages = with pkgs; [ inter ];
}
