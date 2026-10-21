# Encrypted DNS: a local dnscrypt-proxy forwards queries to Cloudflare over DoH so the ISP
# can't see them. The static stamp avoids any bootstrap lookup. 1.1.1.1 stays as a plain
# fallback so a dead proxy (or a captive portal) can't take down all name resolution.
{ lib, ... }:
{
  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      listen_addresses = [ "127.0.0.1:53" ];
      server_names = [ "cloudflare" ];
      static.cloudflare.stamp = "sdns://AgcAAAAAAAAABzEuMS4xLjEAEmRucy5jbG91ZGZsYXJlLmNvbQovZG5zLXF1ZXJ5";
    };
  };

  # macOS refuses to let a non-root user bind 127.0.0.1:53 ("bind: permission denied"), which
  # crash-loops the module's default _dnscrypt-proxy user. Run it as root instead.
  launchd.daemons.dnscrypt-proxy.serviceConfig = {
    UserName = lib.mkForce "root";
    GroupName = lib.mkForce "wheel";
  };

  networking = {
    # nix-darwin skips services that don't exist, so one list covers every Mac.
    knownNetworkServices = [
      "Ethernet"
      "USB 10/100/1000 LAN"
      "Thunderbolt Ethernet"
      "Wi-Fi"
    ];
    dns = [
      "127.0.0.1"
      "1.1.1.1"
    ];
  };
}
