{
  config,
  lib,
  mylib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.pi-coding-agent;
  jsonFormat = pkgs.formats.json {};
in {
  options.programs.pi-coding-agent = {
    my-settings = mkOption {
      inherit (jsonFormat) type;
      default = {};
    };
  };

  config = mkIf cfg.enable {
    programs.pi-coding-agent = {
      my-settings = {
        packages = [
          "npm:pi-undo-redo"
        ];
        tuiMode = "fullscreen";
      };
    };

    home.activation = mkIf (cfg.my-settings != {}) {
      piCodingAgentConfig =
        lib.hm.dag.entryAfter ["linkGeneration"]
        (mylib.mkJSONMutableConfig {
          value = cfg.my-settings;
          dest = "${config.home.homeDirectory}/.pi/agent/settings.json";
        });
    };
  };
}
