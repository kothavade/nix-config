# Every machine pulls main and switches itself when a new commit lands (push to deploy).
# Push to `testing-<hostname>` to try a change on one machine without making it the boot default.
#
# The repo is private: put a fine-grained GitHub token (Contents: read-only, this repo only)
# at the path below on each machine, owned by root with mode 600.
_: {
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/kothavade/nix-config.git";
        auth.access_token_path = "/etc/comin/github-token";
      }
    ];
  };
}
