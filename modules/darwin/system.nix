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
  # llm-agents.nix (claude-code, codex) is prebuilt here; see its input in flake.nix.
  nix.settings = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
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
