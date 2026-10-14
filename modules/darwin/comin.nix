# Keeps comin deploying without anyone watching.
#
# Stable plist: comin's upstream plist embeds store paths (binary, config, PATH), so any comin,
# nix or git bump changes it. nix-darwin then unloads the service mid-switch, which kills comin
# and the activation it is running, leaving a half-applied system and comin not loaded at all.
# Pointing the plist at /etc/comin symlinks keeps it byte-identical across bumps.
#
# Watchdog: with a stable plist nothing restarts comin onto new code, and comin never retries a
# commit whose evaluation failed (e.g. a network blip), so every 10 minutes this (re)starts it
# when it isn't loaded, its code or config changed, or the last evaluation failed. It never
# interrupts a running activation.
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (import "${inputs.comin}/nix/comin-config.nix" { inherit config lib pkgs; })
    cominConfigYaml
    ;
  label = "com.github.nlewo.comin";
  plist = "/Library/LaunchDaemons/${label}.plist";
  state = "/var/lib/comin/watchdog-started";

  watchdog = pkgs.writeShellApplication {
    name = "comin-watchdog";
    runtimeInputs = [ pkgs.curl ];
    text = ''
      log() { echo "$(date '+%F %T') $*"; }
      current="$(readlink -f /etc/comin/env) $(readlink -f /etc/comin/config.yaml)"
      start() {
        log "$1; restarting comin"
        if /bin/launchctl print "system/${label}" >/dev/null 2>&1; then
          /bin/launchctl kickstart -k "system/${label}"
        else
          /bin/launchctl bootstrap system ${plist}
        fi
        echo "$current" >${state}
      }

      if /usr/bin/pgrep -qf 'darwin-system-[^ ]*/activate'; then
        exit 0
      fi
      if ! /bin/launchctl print "system/${label}" >/dev/null 2>&1; then
        start "comin is not loaded"
      elif [ "$(cat ${state} 2>/dev/null)" != "$current" ]; then
        start "comin code or config changed"
      elif curl -sf --max-time 10 http://127.0.0.1:${toString config.services.comin.exporter.port}/metrics \
        | grep -q '^comin_last_eval_failed 1'; then
        start "last evaluation failed"
      fi
    '';
  };
in
{
  environment.etc."comin/env".source = pkgs.buildEnv {
    name = "comin-env";
    paths = [
      config.services.comin.package
      config.nix.package
      pkgs.git
      pkgs.openssh
    ];
  };
  environment.etc."comin/config.yaml".source = cominConfigYaml;

  launchd.daemons.comin = {
    command = lib.mkForce "/etc/comin/env/bin/comin run --config /etc/comin/config.yaml";
    serviceConfig.EnvironmentVariables.PATH = lib.mkForce "/etc/comin/env/bin";
  };

  launchd.daemons.comin-watchdog = {
    command = lib.getExe watchdog;
    serviceConfig = {
      StartInterval = 600;
      StandardOutPath = "/var/log/comin-watchdog.log";
      StandardErrorPath = "/var/log/comin-watchdog.log";
    };
  };
}
