{
  lib,
  pkgs,
  ...
}: {
  programs = {
    nix-index-database.comma.enable = true;
    nix-index.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
        set -g async_prompt_functions _pure_prompt_git
        set -Ux DIRENV_LOG_FORMAT ""
        set -U pure_symbol_prompt "λ"
        set -U pure_symbol_reverse_prompt "λ"
        set -U pure_enable_single_line_prompt true
        set -U pure_enable_nixdevshell true
        set -U pure_symbol_nixdevshell_prefix " "
      '';
      shellAliases = with pkgs; {
        cat = "${bat}/bin/bat --paging never ";
        "ai" = "gh copilot suggest";
        "ssh" = "kitten ssh";
        "today" = ''
          icalBuddy -f -iep "title,datetime" -po "datetime,title" -df "%RD" eventsToday'';
      };
      shellAbbrs = {"lc" = "cd ~/Code/leetcode/ && nvim lc";};
      functions =
        # TODO: find a clean way to make this darwin only (lib.optionals, mkMerge, etc.)
        {
          copy = "cat $argv[1] | pbcopy";
        };
      plugins = with pkgs.fishPlugins; [
        {
          name = "pure";
          inherit (pure) src;
        }
        {
          name = "async-prompt";
          inherit (async-prompt) src;
        }
        {
          name = "plugin-git";
          inherit (plugin-git) src;
        }
        {
          name = "fzf-fish";
          inherit (fzf-fish) src;
        }
      ];
    };
  };
  home.file.".config/fish/themes/gruvbox.theme".source = ./default.nix;
}
