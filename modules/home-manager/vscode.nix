{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.vscode;
in {
  config = {
    programs.vscode = {
      profiles = {
        default = {
          extensions = with pkgs.vscode-extensions; [
            asvetliakov.vscode-neovim
            catppuccin.catppuccin-vsc
            eamodio.gitlens
            emmanuelbeziat.vscode-great-icons
            streetsidesoftware.code-spell-checker
            wakatime.vscode-wakatime
          ];
          userSettings = {
            # Editor
            "editor.accessibilitySupport" = "off";
            "editor.codeActionsOnSave" = {
              "source.fixAll.eslint" = "explicit";
            };
            "editor.colorDecorators" = false;
            "editor.formatOnSave" = true;
            "editor.insertSpaces" = true;
            "editor.minimap.enabled" = false;
            "editor.occurrencesHighlight" = "off";
            "editor.rulers" = [80 100 120];
            "editor.stickyScroll.enabled" = false;
            "editor.suggestSelection" = "first";
            "editor.tabSize" = 2;

            # File
            "files.associations" = {
              # "*.js" = "javascriptreact",
              "[Dd]ockerfile*" = "dockerfile";
              "docker-compose*" = "yaml";
              ".zsh*" = "shellscript";
              ".env*" = "dotenv";
            };
            "files.exclude" = {
              "**/.DS_Store" = true;
              "**/.git" = true;
            };
            "files.trimFinalNewlines" = true;
            "files.trimTrailingWhitespace" = true;

            # Workbench
            # "workbench.colorTheme" = "Default Dark+";
            "workbench.colorTheme" = "Catppuccin Mocha";
            "workbench.editor.enablePreview" = true;
            "workbench.editor.highlightModifiedTabs" = true;
            "workbench.iconTheme" = "vscode-great-icons";
            "workbench.sideBar.location" = "left";

            # Explorer
            "explorer.openEditors.visible" = 0;
            "explorer.confirmDelete" = false;
            "explorer.confirmDragAndDrop" = false;

            # Git
            "git.autofetch" = true;
            "git.confirmSync" = false;
            "git.mergeEditor" = false;
            # Git lens
            "gitlens.codeLens.enabled" = false;
            "gitlens.views.searchAndCompare.files.layout" = "list";

            # Window
            "window.commandCenter" = false;
            "window.title" = "\${rootName}\${separator}\${activeEditorShort}\${separator}\${profileName}";

            # Neovim
            "extensions.experimental.affinity" = {
              "asvetliakov.vscode-neovim" = 1;
            };

            # Tabnine
            "tabnine.experimentalAutoImports" = true;

            "redhat.telemetry.enabled" = false;

            # CSpell
            "cSpell.ignoreRegExpList" = [
              "/[\\u0E00-\\u0E7F]/g"
            ];
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
            # https://stackoverflow.com/questions/52093417/switch-cursor-from-editor-to-file-explorer-and-vice-versa-in-vs-code
            {
              key = "ctrl+h";
              command = "-vscode-neovim.send";
            }
            {
              key = "ctrl+h";
              command = "workbench.action.focusLeftGroup";
              when = "editorTextFocus && neovim.ctrlKeysNormal.h && neovim.init && neovim.mode != 'insert'";
            }
            {
              key = "ctrl+h";
              command = "workbench.action.focusSideBar";
              when = "editorTextFocus && neovim.ctrlKeysNormal.h && neovim.init && neovim.mode != 'insert' && activeEditorGroupIndex == 1 && sideBarVisible";
            }
            {
              key = "ctrl+l";
              command = "-vscode-neovim.send";
            }
            {
              key = "ctrl+l";
              command = "workbench.action.focusRightGroup";
              when = "editorTextFocus && neovim.ctrlKeysNormal.h && neovim.init && neovim.mode != 'insert'";
            }
            {
              key = "ctrl+l";
              command = "workbench.action.focusFirstEditorGroup";
              when = "sideBarFocus";
            }
          ];
        };
      };
    };

    programs.fish = mkIf (cfg.package == pkgs.vscodium) {
      shellAliases = {
        code = "codium";
      };
    };
  };
}
