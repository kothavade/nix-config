{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    fzf
    fd
  ];
  programs = {
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    lsd = {
      enable = true;
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
        set -U pure_symbol_nixdevshell_prefix " "

        # No Clown Fiesta, in hex: the theme's bright ANSI slots are near-black, which fish's
        # default theme leans on (brred errors, brgreen user, ...). Globals override that theme.
        set -g fish_color_normal E1E1E1
        set -g fish_color_command 88AFA2
        set -g fish_color_keyword 7E97AB
        set -g fish_color_quote A2B5C1
        set -g fish_color_escape A2B5C1
        set -g fish_color_redirection 7E97AB
        set -g fish_color_end 7E97AB
        set -g fish_color_operator 7E97AB
        set -g fish_color_error B46958
        set -g fish_color_param E1E1E1
        set -g fish_color_option AFAFAF
        set -g fish_color_comment 727272
        set -g fish_color_autosuggestion 727272
        set -g fish_color_valid_path --underline
        set -g fish_color_selection --background=373737
        set -g fish_color_search_match FFA557 --background=202020
        set -g fish_color_history_current --bold
        set -g fish_color_cancel -r
        set -g fish_color_cwd BAD7FF
        set -g fish_color_cwd_root B46958
        set -g fish_color_user 90A959
        set -g fish_color_host E1E1E1
        set -g fish_color_host_remote F4BF75
        set -g fish_color_status B46958
        set -g fish_pager_color_prefix BAD7FF --bold
        set -g fish_pager_color_completion E1E1E1
        set -g fish_pager_color_description 727272
        set -g fish_pager_color_progress 151515 --background=88AFA2
        set -g fish_pager_color_selected_background --background=373737
      '';
      shellAliases = {
        cat = "bat --paging never";
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
}
