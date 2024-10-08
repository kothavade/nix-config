{ pkgs, ... }:
{
  programs = {
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
        set -U pure_symbol_reverse_prompt "Λ"
        set -U pure_enable_single_line_prompt true
        set -U pure_enable_nixdevshell true
        set -U pure_symbol_nixdevshell_prefix " "
      '';
      shellAliases = with pkgs; {
        cat = "${bat}/bin/bat --paging never ";
        "ai" = "gh copilot suggest";
        "ssh" = "kitten ssh";
        "today" = ''icalBuddy -f -iep "title,datetime" -po "datetime,title" -df "%RD" eventsToday'';
      };
      shellAbbrs = {
        "lc" = "cd ~/Code/leetcode/ && nvim lc";
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
        {
          name = "autopair";
          inherit (autopair) src;
        }
        {
          name = "sponge";
          inherit (sponge) src;
        }
      ];
    };
  };
  home.file.".config/fish/themes/gruvbox.theme".source = ./gruvbox.theme;
}
