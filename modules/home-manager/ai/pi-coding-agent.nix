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

    programs.fish = {
      functions = {
        pi = {
          description = "Run Pi with tmux CSI-u extended keys enabled";
          body =
            #sh
            ''
              if not set -q TMUX
                command pi $argv
                return $status
              end

              set -l old_extended_keys (tmux show-options -s -v extended-keys)
              set -l old_extended_keys_format (tmux show-options -s -v extended-keys-format)
              set -l old_terminal_features (tmux show-options -s -v terminal-features)

              tmux set-option -s extended-keys always
              tmux set-option -s extended-keys-format csi-u
              tmux set-option -s terminal-features "$old_terminal_features,xterm*:extkeys"

              command pi $argv
              set -l pi_status $status

              # Pi enables CSI-u extended keys only while it is running. Keeping
              # these server options global breaks external-editor handoffs in Codex.
              tmux set-option -s extended-keys "$old_extended_keys"
              tmux set-option -s extended-keys-format "$old_extended_keys_format"
              tmux set-option -s terminal-features "$old_terminal_features"

              return $pi_status
            '';
        };
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
