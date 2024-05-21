_: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  services.tailscale.enable = true;

  security.sudo.extraConfig = ''
    Defaults env_reset,pwfeedback
  '';

  system.stateVersion = "24.05";
}
