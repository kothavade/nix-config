{pkgs, ...}: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    # only needed to bootstrap.
    # vim git gmake
  ];

  services.tailscale.enable = true;

  system.stateVersion = "24.05";
}
