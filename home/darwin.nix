_: {
  programs.fish.functions = {
    copy = "cat $argv[1] | pbcopy";
  };
  nix-index-database.comma.enable = true;
  nix-index.enable = true;
}
