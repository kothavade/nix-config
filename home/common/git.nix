{ pkgs, ... }:
let
  credential = if pkgs.stdenv.isDarwin then
    "osxkeychain"
    # TODO: Research libsecret or netrc as encrypted alt to store
    # https://stackoverflow.com/questions/53305965/whats-the-best-encrypted-git-credential-helper-for-linux
    # https://stackoverflow.com/questions/18838579/how-to-store-your-github-https-password-on-linux-in-a-terminal-keychain
  else
    "store";
in {
  programs.git = {
    enable = true;
    userName = "Ved Kothavade";
    userEmail = "ved@kothavade.com";
    delta = {
      enable = true;
      options = {
        navigate = true;
        light = false;
      };
    };
    ignores = [ "**/.idea/" "**/.direnv/" "**/.DS_Store" ];
    extraConfig = {
      pull.ff = "only";
      credential.helper = credential;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
    };
  };
}
