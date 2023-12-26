{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    mutableExtensionsDir = true;
    userSettings = with pkgs; {
      "files.autoSave" = "afterDelay";

      "workbench.colorTheme" = "Min Dark";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";

      "window.commandCenter" = false;

      "editor.fontLigatures" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.fontFamily" = "Liga SFMono Nerd Font";
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = true;
      "editor.formatOnType" = true;
      "editor.stickyScroll.enabled" = true;
      "editor.minimap.enabled" = false;
      "editor.codeActionsOnSave" = {
        "source.fixAll" = true;
        "source.organizeImports.biome" = true;
      };
      "editor.linkedEditing" = true;

      "explorer.confirmDelete" = false;

      "terminal.integrated.fontFamily" = "Liga SFMono Nerd Font";
      "terminal.integrated.macOptionIsMeta" = true;
      "terminal.integrated.profiles.osx" = {
        "fish" = {
          "path" = "${fish}/bin/fish";
          "args" = [ "-l" ];
        };
      };
      "terminal.integrated.defaultProfile.osx" = "fish";

      "terminal.integrated.env.osx" = { };

      "workbench.layoutControl.enabled" = false;

      "git.autofetch" = true;
      "git.confirmSync" = false;

      "extensions.experimental.affinity" = { "asvetliakov.vscode-neovim" = 1; };

      "leetcode.workspaceFolder" = "/Users/ved/Code/leetcode";
      "leetcode.defaultLanguage" = "python3";

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${nil}/bin/nil";
      "nix.serverSettings" = {
        "nil" = { "formatting" = { "command" = [ "nixfmt" ]; }; };
        "nixd" = {
          "options" = { "enable" = true; };
          "formatting" = { "command" = [ "nixfmt" ]; };
        };
      };

      "[python]" = {
        "editor.defaultFormatter" = "ms-python.python";
        "editor.formatOnSave" = true;
      };

      "[javascript]" = { "editor.defaultFormatter" = "biomejs.biome"; };
      "[javascriptreact]" = { "editor.defaultFormatter" = "biomejs.biome"; };
      "[typescript]" = { "editor.defaultFormatter" = "biomejs.biome"; };
      "[typescriptreact]" = { "editor.defaultFormatter" = "biomejs.biome"; };
      "[css]" = { "editor.defaultFormatter" = "biomejs.biome"; };
      "[html]" = { "editor.defaultFormatter" = "biomejs.biome"; };

      # Java
      "redhat.telemetry.enabled" = false;

      # Typst/Markdown
      "languageToolLinter.managed.classPath" =
        "${languagetool}/share/languagetool-server.jar";
      "languageToolLinter.serviceType" = "managed";
    };
  };
}
