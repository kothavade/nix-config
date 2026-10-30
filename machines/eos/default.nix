# M4 Mac mini
_: {
  # chatgpt: ariadne drives OpenAI's Computer Use component through this app's app-server.
  # It updates itself (auto_updates), so Homebrew only installs it.
  homebrew.casks = [
    "chatgpt"
    "middleclick"
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
