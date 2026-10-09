_: {
  programs.git = {
    enable = true;
    ignores = [
      "**/.idea/"
      "**/.direnv/"
      "**/.DS_Store"
    ];
    signing = {
      format = "ssh";
      # Bitwarden SSH agent key ("bw ssh key").
      key = "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJOAm1RLAlDnqjZeSuABKIpRERsIsWxJvtWh8YIPE8iU";
      signByDefault = true;
    };
    settings = {
      user.name = "Ved Kothavade";
      user.email = "ved@kothavade.com";
      pull.ff = "only";
      credential.helper = "osxkeychain";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
