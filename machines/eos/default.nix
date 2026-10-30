# M4 Mac mini
{ inputs, pkgs, ... }:
{
  homebrew.casks = [ "middleclick" ];

  # ChatGPT desktop app (lands in /Applications/Nix Apps). ariadne drives OpenAI's Computer Use
  # component through this app's bundled app-server. From Nix rather than Homebrew so it can't
  # update itself: that API is experimental, so new versions arrive only through flake.lock bumps
  # and can be reverted. The Nix copy keeps OpenAI's signature, which the bridge checks.
  environment.systemPackages = [
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.chatgpt
  ];

  # Open-source tailscaled (not the GUI app), since only it can act as a Tailscale SSH server.
  # After the first switch: sudo tailscale up --ssh --advertise-exit-node
  services.tailscale.enable = true;

  # Always-on server: never sleep, and come back on its own after a power cut or a hang.
  power = {
    sleep.computer = "never";
    restartAfterPowerFailure = true;
    restartAfterFreeze = true;
  };

  system.stateVersion = 6;
}
