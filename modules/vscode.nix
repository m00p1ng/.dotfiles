{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      Arjun.swagger-viewer
      WakaTime.vscode-wakatime
      eamodio.gitlens
      emmanuelbeziat.vscode-great-icons
      streetsidesoftware.code-spell-checker
      tabnine.tabnine-vscode
      # vscodevim.vim
      asvetliakov.vscode-neovim

      # Vscode only
      # ms-vsliveshare.vsliveshare
    ];
    userSettings = {
      # Editor
      "editor.colorDecorators" = false;
      "editor.formatOnSave" = true;
      "editor.insertSpaces" = true;
      "editor.occurrencesHighlight" = false;
      "editor.suggestSelection" = "first";
      "editor.tabSize" = 2;
      "editor.rulers" = [80 100 120];
      "editor.minimap.enabled" = false;
      "editor.codeActionsOnSave" = {
        "source.fixAll.eslint" = true;
      };
      "editor.accessibilitySupport" = "off";

      # File
      "files.exclude" = {
        "**/.git" = true;
        "**/.DS_Store" = true;
      };
      "files.associations" = {
        # "*.js" = "javascriptreact",
        "[Dd]ockerfile*" = "dockerfile";
        "docker-compose*" = "yaml";
        ".zsh*" = "shellscript";
        ".env*" = "dotenv";
      };
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;

      # Workbench
      "workbench.editor.highlightModifiedTabs" = true;
      "workbench.editor.enablePreview" = true;
      "workbench.sideBar.location" = "left";
      "workbench.iconTheme" = "vscode-great-icons";
      "workbench.colorTheme" = "Default Dark+";

      # Explorer
      "explorer.openEditors.visible" = 0;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;

      # Git
      "git.mergeEditor" = false;
      "git.autofetch" = true;
      "git.confirmSync" = false;
      # Git lens
      "gitlens.codeLens.enabled" = false;
      "gitlens.views.searchAndCompare.files.layout" = "list";

      # Window
      "window.commandCenter" = false;

      # Vim
      # "vim.hlsearch" = true;
      # "vim.normalModeKeyBindingsNonRecursive" = [
      #   {
      #     "before" = ["<leader>" "e"];
      #     "after" = [];
      #     "commands" = [
      #       {
      #         "command" = "editor.action.commentLine";
      #         "when" = "editorTextFocus && !editorReadonly";
      #       }
      #     ];
      #   }
      # ];
      # "vim.visualModeKeyBindingsNonRecursive" = [
      #   {
      #     "before" = ["<leader>" "e"];
      #     "after" = [];
      #     "commands" = [
      #       {
      #         "command" = "editor.action.commentLine";
      #         "when" = "editorTextFocus && !editorReadonly";
      #       }
      #     ];
      #   }
      # ];

      # Neovim
      "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
      };

      # Tabnine
      "tabnine.experimentalAutoImports" = true;

      "redhat.telemetry.enabled" = false;
    };

    keybindings = [
      {
        key = "cmd+1";
        command = "workbench.action.openEditorAtIndex1";
      }
      {
        key = "cmd+2";
        command = "workbench.action.openEditorAtIndex2";
      }
      {
        key = "cmd+3";
        command = "workbench.action.openEditorAtIndex3";
      }
      {
        key = "cmd+4";
        command = "workbench.action.openEditorAtIndex4";
      }
      {
        key = "cmd+5";
        command = "workbench.action.openEditorAtIndex5";
      }
      {
        key = "cmd+6";
        command = "workbench.action.openEditorAtIndex6";
      }
      {
        key = "cmd+7";
        command = "workbench.action.openEditorAtIndex7";
      }
      {
        key = "cmd+8";
        command = "workbench.action.openEditorAtIndex8";
      }
      {
        key = "cmd+9";
        command = "workbench.action.openEditorAtIndex9";
      }
    ];
  };

  programs.fish = {
    shellAliases = {
      code = "codium";
    };
  };
}
