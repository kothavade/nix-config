{ pkgs, ... }: {
  programs = {
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
      '';
      shellAliases = with pkgs; {
        cat = "${bat}/bin/bat --paging never ";
        "?" = "gh copilot suggest";
        "today" = ''
          icalBuddy -f -iep "title,datetime" -po "datetime,title" -df "%RD" eventsToday'';
      };
      shellAbbrs = { "lc" = "cd ~/Code/leetcode/ && nvim lc"; };
      plugins = with pkgs.fishPlugins; [
        # TODO: nix support in mainline pure: https://github.com/pure-fish/pure/pull/338
        {
          name = "pure";
          src = pkgs.fetchFromGitHub {
            owner = "m15a";
            repo = "pure";
            rev = "d48237484fd3e3761221e8f1c26e819673b91a93";
            sha256 = "sha256-YyDsZ1FTIZwCzgNt4SX19VxqY+1avHvyabcSePW59+g=";
          };
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
  home.file.".config/fish/themes/zenbones.theme".text = ''
    fish_color_autosuggestion 'brblack'  '-di'
    fish_color_cancel red
    fish_color_command 'white'  '-o'
    fish_color_comment brred
    fish_color_cwd
    fish_color_cwd_root red
    fish_color_end purple
    fish_color_error
    fish_color_escape yellow
    fish_color_history_current --bold
    fish_color_host
    fish_color_host_remote
    fish_color_keyword purple
    fish_color_normal white
    fish_color_operator yellow
    fish_color_param white
    fish_color_quote 'yellow'  '-i'
    fish_color_redirection brgreen
    fish_color_search_match orange
    fish_color_selection orange
    fish_color_status red
    fish_color_user
    fish_color_valid_path --underline
    fish_pager_color_completion 'normal'  '-i'
    fish_pager_color_description 'normal'  '-d'
    fish_pager_color_prefix
    fish_pager_color_progress 'blue'  '-d'
    fish_pager_color_selected_background bryellow
    fish_pager_color_selected_completion
    fish_pager_color_selected_description brblack
    fish_pager_color_selected_prefix
  '';
}
