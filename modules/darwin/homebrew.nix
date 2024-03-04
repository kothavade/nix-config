_: {
  homebrew = {
    enable = true;
    # global.autoUpdate = false;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [ "ical-buddy" ];
    taps = [
      "shaunsingh/SFMono-Nerd-Font-Ligaturized"
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
      # dev
      "orbstack"
      "tailscale"
      # browsers
      "firefox-developer-edition"
      "google-chrome"
      "arc"
      "microsoft-edge"
      # games
      "steam"
      # communication
      "zoom"
      # security
      "lulu"
      # fonts
      "font-linux-biolinum"
      "font-sf-mono-nerd-font-ligaturized"
      "font-sf-mono"
      "font-sf-pro"
    ];
    masApps = {
      "wireguard" = 1451685025;
      "bitwarden" = 1352778147;
      # safari extensions
      "adguard" = 1440147259;
      "hush" = 1544743900;
      "vinegar" = 1591303229;
      "sponsorblock" = 1573461917;
    };
  };
}
