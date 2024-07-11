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
	persistent-apps = [
	  "/Applications/Safari.app"
	  "/Applications/Messages.app"
	  "/Applications/Mail.app"
	  "/Applications/Settings.app"
	  "/Applications/kitty.app"
	];
      };
      CustomUserPreferences."com.microsoft.VSCode"."ApplePressAndHoldEnabled" = false;
      screencapture.location = "/tmp";
      NSGlobalDomain."com.apple.swipescrolldirection" = false;
    };
  };
  system.stateVersion = 4;
  services.nix-daemon.enable = true;
  nix.gc = {
    user = "root";
    automatic = true;
    interval = { Weekday = 0; Hour = 2; Minute = 0; };
    options = "--delete-older-than 30d";
  };
}
