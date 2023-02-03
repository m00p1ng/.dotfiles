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
      vscodevim.vim

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
      "gitlens.codeLens.enabled" = false;
      "gitlens.views.searchAndCompare.files.layout" = "list";

      # Vim
      "vim.hlsearch" = true;
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          "before" = ["<leader>" "e"];
          "after" = [];
          "commands" = [
            {
              "command" = "editor.action.commentLine";
              "when" = "editorTextFocus && !editorReadonly";
            }
          ];
        }
      ];
      "vim.visualModeKeyBindingsNonRecursive" = [
        {
          "before" = ["<leader>" "e"];
          "after" = [];
          "commands" = [
            {
              "command" = "editor.action.commentLine";
              "when" = "editorTextFocus && !editorReadonly";
            }
          ];
        }
      ];

      # Tabnine
      "tabnine.experimentalAutoImports" = true;
    };
  };

  programs.fish = {
    shellAliases = {
      code = "codium";
    };
  };
}
