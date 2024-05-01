_: {
  homebrew = {
    enable = true;
    # global.autoUpdate = false;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = ["ical-buddy"];
    taps = [
      "mrkai77/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
    ];
    casks = [
      # system
      "raycast"
      "karabiner-elements"
      "middleclick"
      "itsycal"
      "iina"
      "keka"
      "loop"
      "amethyst"
      "vial"
      # dev
      "orbstack"
      "tailscale"
      "visual-studio-code"
      # browsers
      "firefox-developer-edition"
      "google-chrome"
      "microsoft-edge"
      # games
      "steam"
      # communication
      "zoom"
      # security
      "lulu"
      # fonts
      "font-linux-biolinum"
    ];
    masApps = {
      "wireguard" = 1451685025;
    };
  };
}
