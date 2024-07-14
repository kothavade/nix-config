_: {
  homebrew = {
    enable = true;
    # global.autoUpdate = false;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      # system
      "raycast"
      "karabiner-elements"
      "itsycal"
      "iina"
      "keka"
      "vial"
      # dev
      # "orbstack"
      "tailscale"
      "visual-studio-code"
      "zed"
      # browsers
      # "firefox-developer-edition"
      # "google-chrome"
      "brave-browser"
      # games
      # "steam"
      # communication
      "zoom"
      # security
      # "lulu"
    ];
    masApps = {
      "wireguard" = 1451685025;
    };
  };
}
