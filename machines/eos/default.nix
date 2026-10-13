# M4 Mac mini
_: {
  imports = [ ./hermes.nix ];

  homebrew.casks = [ "middleclick" ];

  # Open-source tailscaled (not the GUI app), since only it can act as a Tailscale SSH server.
  # After the first switch: sudo tailscale up --ssh --advertise-exit-node
  services.tailscale.enable = true;

  # Always-on server: never sleep, and come back on its own after a power cut or a hang.
  # Hermes runs as a launch agent, so it also needs automatic login, which can't be set
  # declaratively: macOS keeps the password in /etc/kcpassword and FileVault must be off.
  # Turn it on once in System Settings → Users & Groups → Automatically log in as.
  power = {
    sleep.computer = "never";
    restartAfterPowerFailure = true;
    restartAfterFreeze = true;
  };

  system.stateVersion = 6;
}
