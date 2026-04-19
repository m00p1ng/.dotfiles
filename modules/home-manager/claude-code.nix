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
  npmPrefix = "${config.home.homeDirectory}/.npm-global";
  npm = "${pkgs.nodejs}/bin/npm --prefix \"${npmPrefix}\"";
  acpPackage = "@agentclientprotocol/claude-agent-acp";
in {
  options.programs.claude-code = {
    acp = {
      enable = mkEnableOption "ACP (Agent Communication Protocol) server";
    };

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
          "playwright@claude-plugins-official" = true;
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

      (mkIf cfg.acp.enable {
        claudeCodeAcp =
          lib.hm.dag.entryAfter ["linkGeneration"] #sh
          
          ''
            if ! ${npm} list --depth=0 ${acpPackage} > /dev/null 2>&1; then
              ${npm} install ${acpPackage}
            elif ! ${npm} outdated ${acpPackage} > /dev/null 2>&1; then
              ${npm} update ${acpPackage}
            fi
          '';
      })
    ];
  };
}
