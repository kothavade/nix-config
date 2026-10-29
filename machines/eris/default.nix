# Oracle Cloud A1 (aarch64) server, originally installed with nixos-infect.
{ pkgs, user, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  # comin switches in place, but a new kernel/initrd only applies on boot. Reboot overnight if
  # the boot default (which comin's `switch` updates, not `testing-*` deploys) differs from what
  # booted; same check as system.autoUpgrade.allowReboot.
  systemd.services.reboot-if-needed = {
    description = "Reboot if the boot default has a new kernel or initrd";
    serviceConfig.Type = "oneshot";
    script = ''
      booted="$(readlink /run/booted-system/{initrd,kernel,kernel-modules})"
      built="$(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})"
      if [ "$booted" != "$built" ]; then
        echo "kernel/initrd changed, rebooting"
        systemctl reboot
      fi
    '';
  };
  systemd.timers.reboot-if-needed = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnCalendar = "*-*-* 04:00:00";
  };

  # Workaround for https://github.com/NixOS/nix/issues/8502
  services.logrotate.checkConfig = false;

  networking = {
    domain = "";
    interfaces.enp0s6.useDHCP = true;
    nameservers = [
      "169.254.169.254"
      "1.1.1.1"
    ];
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  # Only reachable over Tailscale.
  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  services.tailscale = {
    useRoutingFeatures = "server";
    openFirewall = true;
    extraSetFlags = [
      "--ssh"
      "--advertise-exit-node"
    ];
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    initialHashedPassword = "!";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9SDEnJI+ueh1lXbrTpG2hoHtc6RfjRxd0RTXjjDdkB ved@kothavade.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJOAm1RLAlDnqjZeSuABKIpRERsIsWxJvtWh8YIPE8iU bw"
    ];
  };
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    git
    curl
    vim
    htop
    tmux
    ghostty.terminfo
  ];

  system.stateVersion = "23.11";
}
