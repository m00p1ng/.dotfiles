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
    my-settings = mkOption {
      inherit (jsonFormat) type;
      default = {};
    };
  };

  config = mkIf cfg.enable {
    programs.claude-code = {
      my-settings = {
        "$schema" = "https://json.schemastore.org/claude-code-settings.json";
        statusLine = {
          type = "command";
          command = "npx ccstatusline@latest";
        };
        enabledPlugins = {
          "claude-code-wakatime@wakatime" = true;
          "code-review@claude-plugins-official" = true;
          "code-simplifier@claude-plugins-official" = true;
          "github@claude-plugins-official" = true;
          "lua-lsp@claude-plugins-official" = true;
          "pyright-lsp@claude-plugins-official" = true;
          "typescript-lsp@claude-plugins-official" = true;
        };
        extraKnownMarketplaces = {
          wakatime = {
            source = {
              source = "git";
              url = "https://github.com/wakatime/claude-code-wakatime.git";
            };
          };
        };
      };
    };

    home.activation = mkMerge [
      (mkIf (cfg.my-settings != {}) {
        claudeCodeConfig =
          lib.hm.dag.entryAfter ["linkGeneration"]
          (mylib.mkMutableConfig {
            src = jsonFormat.generate "claude-code-settings.json" cfg.my-settings;
            dest = "${config.home.homeDirectory}/.claude/settings.json";
          });
      })
    ];
  };
}
