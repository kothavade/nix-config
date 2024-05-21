_: {
  security.pam.enableSudoTouchIdAuth = true;
  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      dock = {
        autohide = true;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };
      CustomUserPreferences."com.microsoft.VSCode"."ApplePressAndHoldEnabled" = false;
      screencapture.location = "/tmp";
      NSGlobalDomain."com.apple.swipescrolldirection" = false;
    };
  };
  system.stateVersion = 4;
  services.nix-daemon.enable = true;
}
