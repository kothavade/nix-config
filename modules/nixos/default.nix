_: {
  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  services.tailscale.enable = true;

  security.sudo.extraConfig = ''
    Defaults env_reset,pwfeedback
  '';

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };
  system.stateVersion = "24.05";
}
