{ user, ... }:
{
  system.primaryUser = user;
  security.pam.services.sudo_local.touchIdAuth = true;
  system = {
    defaults = {
      dock = {
        autohide = true;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };
      screencapture.location = "/tmp";
      NSGlobalDomain."com.apple.swipescrolldirection" = false;
    };
  };
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 2;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };
}
