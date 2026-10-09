# The app itself comes from the homebrew cask.
_: {
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      theme = "Oxocarbon";
      unfocused-split-opacity = 0.8;
      macos-titlebar-style = "tabs";
      macos-option-as-alt = true;
      macos-icon = "xray";
      font-thicken = false;
      # Replaces `kitten ssh`: copies Ghostty's terminfo to the remote and forwards env.
      shell-integration-features = "ssh-env,ssh-terminfo";
      keybind = [ "global:cmd+escape=toggle_quick_terminal" ];

      # No clown fiesta
      palette = [
        "0=#151515"
        "1=#b46958"
        "2=#90A959"
        "3=#F4BF75"
        "4=#BAD7FF"
        "5=#AA759F"
        "6=#88AFA2"
        "7=#E1E1E1"
        "8=#AFAFAF"
        "9=#201919"
        "10=#1C2019"
        "11=#F4BF75"
        "12=#191A20"
        "13=#AA759F"
        "14=#88AFA2"
        "15=#E1E1E1"
      ];
      background = "#151515";
      foreground = "#E1E1E1";
      cursor-color = "#D0D0D0";
      selection-background = "#E1E1E1";
      selection-foreground = "#151515";
    };
  };
}
