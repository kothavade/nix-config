{ pkgs, ... }: {
  programs = {
    starship.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      # enableFishIntegration = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    lsd = {
      enable = true;
      enableAliases = true;
      settings.hyperlink = "auto";
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
      shellAliases = with pkgs; {
        cat = "${bat}/bin/bat --paging never ";
        "," = " __copilot_what-the-shell";
        ",g" = " __copilot_git-assist";
        ",gh" = " __copilot_gh-assist";
        "today" = ''
          icalBuddy -f -iep "title,datetime" -po "datetime,title" -df "%RD" eventsToday'';
      };
      plugins = with pkgs.fishPlugins; [
        {
          name = "plugin-git";
          inherit (plugin-git) src;
        }
        {
          name = "fzf-fish";
          inherit (fzf-fish) src;
        }
        {
          name = "github-copilot-cli-fish";
          inherit (github-copilot-cli-fish) src;
        }
      ];
    };
  };

}
