_: {
  programs.fish.functions = {
    copy = "cat $argv[1] | pbcopy";
  };
}
