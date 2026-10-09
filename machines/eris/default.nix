# Oracle Cloud A1 (aarch64) server, originally installed with nixos-infect.
{ pkgs, user, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIErVyDQRMn5bRa9Lp9MRhCoVmirYsrxIom7CXhMquZjQ kat"
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
