# The app itself comes from the homebrew cask.
{ inputs, ... }:
{
  # Upstream theme file, bumped with the rest of flake.lock.
  xdg.configFile."ghostty/themes/no-clown-fiesta".source =
    "${inputs.no-clown-fiesta-ghostty}/no-clown-fiesta.ghostty";
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      theme = "no-clown-fiesta";
      # Upstream's bright red/green/blue are near-black background tints; make them readable
      # like its bright yellow/magenta/cyan, which mirror the normal colors.
      palette = [
        "9=#B46958"
        "10=#90A959"
        "12=#BAD7FF"
      ];
      unfocused-split-opacity = 0.8;
      macos-titlebar-style = "tabs";
      macos-option-as-alt = true;
      macos-icon = "xray";
      font-thicken = false;
      # Replaces `kitten ssh`: copies Ghostty's terminfo to the remote and forwards env.
      shell-integration-features = "ssh-env,ssh-terminfo";
      keybind = [ "global:cmd+escape=toggle_quick_terminal" ];
    };
  };
}
