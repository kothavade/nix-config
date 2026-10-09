# Shared by every Mac. Per-machine casks live in machines/<name>.nix.
_: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # Anything not listed here (or in the machine file) is uninstalled on switch.
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      "bitwarden"
      "claude-code"
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
