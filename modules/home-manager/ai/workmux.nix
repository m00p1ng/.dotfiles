{
  config,
  lib,
  pkgs,
  mylib,
  ...
}:
with lib; let
  cfg = config.programs.workmux;
  jsonFormat = pkgs.formats.json {};
in {
  options.programs.workmux = {
    enable = mkEnableOption "workmux";
    my-settings = mkOption {
      inherit (jsonFormat) type;
      default = {};
    };
  };

  config = mkIf cfg.enable {
    programs.workmux = {
      my-settings = {
        nerdfont = true;
        merge_strategy = "rebase";
        panes = [
          {
            command = "nvim";
            focus = true;
          }
        ];
        sidebar = {
          position = "left"; # "left" (default) or "top"
          width = 30; # left width in columns, or "15%" for percentage
          layout = "tiles"; # left only: "compact" or "tiles" (default)
        };
      };
    };

    home.activation = {
      workmuxConfig =
        lib.hm.dag.entryAfter ["linkGeneration"]
        (mylib.mkYamlMutableConfig {
          value = cfg.my-settings;
          dest = "${config.xdg.configHome}/workmux/config.yaml";
        });
    };

    programs.fish = {
      shellAbbrs = {
        wm = "workmux";
      };
      interactiveShellInit =
        #sh
        ''
          # workmux configuration
          workmux completions fish | source
        '';
    };
  };
}
