# Every machine pulls main and switches itself when a new commit lands (push to deploy).
# Push to `testing-<hostname>` to try a change on one machine without making it the boot default.
#
# The repo is private: each machine has its own read-only deploy key at the path below
# (root, mode 600), registered with `gh repo deploy-key add`.
_: {
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "git@github.com:kothavade/nix-config.git";
        auth = {
          ssh_deploy_key_path = "/etc/comin/deploy-key";
          # comin uses this as the SSH user (default "comin"), ignoring the `git@` in the URL.
          username = "git";
        };
      }
    ];
  };

  # comin verifies the remote against /etc/ssh/ssh_known_hosts.
  programs.ssh.knownHosts."github.com".publicKey =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
}
