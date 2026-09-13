{
  config,
  lib,
  mylib,
  pkgs,
  ...
}:
with lib; let
  # lspRoot = "${config.xdg.dataHome}/nvim/mason/bin";
  cfg = config.programs.opencode;
  jsonFormat = pkgs.formats.json {};
in {
  options.programs.opencode = {
    my-settings = mkOption {
      inherit (jsonFormat) type;
      default = {};
    };
  };

  config = mkIf cfg.enable {
    programs.opencode = {
      my-settings = {
        "$schema" = "https://opencode.ai/config.json";
        autoupdate = false;
        plugin = [
          "opencode-wakatime"
          "superpowers@git+https://github.com/obra/superpowers.git"
        ];
      };
      tui = {
        keybinds = {
          leader = "ctrl+o";
          input_visual_line_end = "none";
          editor_open = "ctrl+g";
        };
      };
    };

    home.activation = mkMerge [
      (mkIf (cfg.my-settings != {}) {
        opencodeConfig =
          lib.hm.dag.entryAfter ["linkGeneration"]
          (mylib.mkJSONMutableConfig {
            value = cfg.my-settings;
            dest = "${config.xdg.configHome}/opencode/opencode.json";
          });
      })
    ];
  };
}
