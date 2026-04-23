{
  config,
  lib,
  mylib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.claude-code;
  jsonFormat = pkgs.formats.json {};
in {
  options.programs.claude-code = {
    my-plugins.statusline = {
      enable = mkEnableOption "claude-code status line";
      settings = mkOption {
        inherit (jsonFormat) type;
        default = {};
      };
    };
  };

  config = mkIf cfg.enable {
    programs.claude-code = {
      my-plugins.statusline = {
        settings = {
          version = 3;
          lines = [
            [
              {
                id = "171ad33c-b43e-493b-8527-d3aafe804a9f";
                type = "custom-text";
                color = "white";
                bold = true;
                customText = "ctx:";
                merge = "no-padding";
              }
              {
                id = "e3c20f86-55c0-4aec-a2b0-c2f77e2e647f";
                type = "context-length";
                color = "white";
                bold = true;
                rawValue = true;
                merge = "no-padding";
              }
              {
                id = "87b3f788-1638-4521-b555-8681641b7d58";
                type = "custom-text";
                color = "white";
                bold = true;
                rawValue = true;
                customText = "(";
                merge = "no-padding";
              }
              {
                id = "49a0387c-7977-4e73-a256-be4fccaf6410";
                type = "context-percentage";
                color = "white";
                bold = true;
                rawValue = true;
                merge = "no-padding";
              }
              {
                id = "c936ca5c-6491-456a-8380-d2d0136a44cf";
                type = "custom-text";
                color = "white";
                bold = true;
                customText = ")";
                merge = "no-padding";
              }
              {
                id = "a837dadb-7751-4c0c-bfd3-efad90d8ca5e";
                type = "separator";
                merge = "no-padding";
              }
              {
                id = "c99a7a1e-8e5f-4683-b51e-bdd19fc2108e";
                type = "custom-text";
                color = "brightBlack";
                customText = "ses:";
                merge = "no-padding";
              }
              {
                id = "b5797712-c4cd-4258-b5c5-460d9bc87bcd";
                type = "session-usage";
                color = "brightBlack";
                rawValue = true;
                metadata = {
                  display = "time";
                };
              }
              {
                id = "7b5fd967-f70b-4204-9873-0a4a752ed5bc";
                type = "custom-text";
                color = "brightBlack";
                customText = "(";
                merge = "no-padding";
              }
              {
                id = "c436a5a8-91ef-400e-a164-c1ebf09f12e8";
                type = "reset-timer";
                color = "brightBlack";
                rawValue = true;
                merge = "no-padding";
              }
              {
                id = "b8219c57-09a6-42b7-85bb-f2f1c3b45283";
                type = "custom-text";
                color = "brightBlack";
                customText = ")";
                merge = "no-padding";
              }
            ]
            [
              {
                id = "5e3d1306-340c-47ff-9d4f-cac536b83170";
                type = "git-root-dir";
                color = "hex:a6d189";
                merge = "no-padding";
              }
              {
                id = "1ff1b95f-555a-48bd-9b1a-d399737f2609";
                type = "custom-text";
                color = "brightBlack";
                customText = ":";
                merge = "no-padding";
              }
              {
                id = "38e4bcfb-157b-4b4b-a25f-5f1a58bb2c2e";
                type = "git-branch";
                color = "hex:E5C890";
                rawValue = true;
              }
              {
                id = "10224917-1ad4-4e9e-8f05-a760134ed5f7";
                type = "separator";
              }
              {
                id = "4d91e296-2f56-4b1c-a921-e2f3098a141c";
                type = "model";
                color = "hex:Ef9F76";
                rawValue = true;
                merge = "no-padding";
              }
              {
                id = "3280bbfb-4a79-46de-8250-e3ca149bdc1c";
                type = "custom-text";
                color = "brightBlack";
                customText = " • ";
                merge = "no-padding";
              }
              {
                id = "41262266-fc2d-4386-9d92-8e23bb15b36e";
                type = "thinking-effort";
                rawValue = true;
                merge = "no-padding";
              }
            ]
          ];
          flexMode = "full-minus-40";
          compactThreshold = 60;
          colorLevel = 3;
          inheritSeparatorColors = false;
          globalBold = false;
          minimalistMode = false;
          powerline = {
            enabled = false;
            separators = [
              ""
            ];
            separatorInvertBackground = [
              false
            ];
            startCaps = [];
            endCaps = [];
            autoAlign = false;
            continueThemeAcrossLines = false;
          };
        };
      };
    };

    home.activation = mkMerge [
      (mkIf (cfg.my-plugins.statusline.enable) {
        claudeCodeStatusline =
          lib.hm.dag.entryAfter ["linkGeneration"]
          (mylib.mkMutableConfig {
            src = jsonFormat.generate "cc-statusline" cfg.my-plugins.statusline.settings;
            dest = "${config.xdg.configHome}/ccstatusline/settings.json";
          });
      })
    ];
  };
}
