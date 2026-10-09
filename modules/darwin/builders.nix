# Linux builds go to eris. Darwin builds stay local: a switch only builds a handful of tiny
# derivations (everything else is substituted), and offloading those to eos measured slower.
# Auth is Tailscale SSH (tailnet identity), so no key is needed; the host key is pinned for root.
_: {
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;
  nix.buildMachines = [
    {
      hostName = "eris";
      sshUser = "ved";
      protocol = "ssh-ng";
      system = "aarch64-linux";
      maxJobs = 4;
      supportedFeatures = [
        "big-parallel"
        "benchmark"
      ];
      publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUNMR0pTeXVHNXhrVjVBZnZ1aWZFc2RUeGVoaElCL3QxUWR6TGlEemhUN0s=";
    }
  ];
}
