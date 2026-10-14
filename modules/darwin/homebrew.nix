# Shared by every Mac. Per-machine casks live in machines/<name>.nix.
_: {
  homebrew = {
    enable = true;
    onActivation = {
      # Deploys run unattended (comin), where .pkg casks can't prompt for sudo, so they only
      # add/remove casks. Upgrade interactively with `make upgrade`.
      autoUpdate = false;
      upgrade = false;
      # Anything not listed here (or in the machine file) is uninstalled on switch.
      cleanup = "zap";
    };
    casks = [
      "bitwarden"
      "ghostty@tip"
      "helium-browser"
      "iina"
      "karabiner-elements"
      "obsidian"
      "raycast"
      "zed"
      "zoom"
    ];
  };
}
