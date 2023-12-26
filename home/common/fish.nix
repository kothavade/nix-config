{ pkgs, ... }: {
  programs = {
    starship = {
      enable = true;
      settings = {
        scan_timeout = 10;
        add_newline = false;
        line_break.disabled = true;
        format =
          "$hostname$directory$git_branch$git_metrics$nix_shell$package$character";
        character = {
          success_symbol = "[λ](green)";
          error_symbol = "[λ](red)";
          vicmd_symbol = "[λ](purple)";
          vimcmd_replace_one_symbol = "[λ](cyan)";
          vimcmd_replace_symbol = "[λ](cyan)";
          vimcmd_visual_symbol = "[λ](yellow)";
        };
        directory = {
          style = "cyan";
          read_only = " ";
        };
        git_branch = {
          style = "purple";
          symbol = "";
        };
        git_metrics = {
          disabled = false;
          added_style = "bold yellow";
          deleted_style = "bold red";
        };
        package.format = "version [$version](bold green) ";
        nix_shell = {
          symbol = " ";
          format = "via [$symbol$name]($style) ";
          impure_msg = "";
          pure_msg = "";
        };
      };
    };
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
        set -Ux DIRENV_LOG_FORMAT ""
      '';
      shellAliases = with pkgs; {
        cat = "${bat}/bin/bat --paging never ";
        "," = " __copilot_what-the-shell";
        ",g" = " __copilot_git-assist";
        ",gh" = " __copilot_gh-assist";
        "today" = ''
          icalBuddy -f -iep "title,datetime" -po "datetime,title" -df "%RD" eventsToday'';
      };
      shellAbbrs = { "lc" = "cd ~/Code/leetcode/ && nvim lc"; };
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
