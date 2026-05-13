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

    my-plugins = {
      rtk = mkEnableOption "rtk hook integration";
      caveman = mkEnableOption "caveman plugin integration";
      wakatime = mkEnableOption "wakatime plugin integration";
      statusline = {
        enable = mkEnableOption "claude-code status line";
        settings = mkOption {
          inherit (jsonFormat) type;
          default = {};
        };
      };
    };

    my-settings = mkOption {
      inherit (jsonFormat) type;
      default = {};
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.claude-code = {
        my-settings = {
          "$schema" = "https://json.schemastore.org/claude-code-settings.json";
          statusLine = {
            type = "command";
            command = "npx ccstatusline@latest";
          };
          enabledPlugins = {
            "code-review@claude-plugins-official" = true;
            "code-simplifier@claude-plugins-official" = true;
            "github@claude-plugins-official" = true;
            "lua-lsp@claude-plugins-official" = true;
            "playwright@claude-plugins-official" = true;
            "pyright-lsp@claude-plugins-official" = true;
            "typescript-lsp@claude-plugins-official" = false;
            "vtsls-lsp@vtsls" = true;
          };
          extraKnownMarketplaces = {
            vtsls = {
              source = {
                source = "directory";
                path = "${config.home.homeDirectory}/.claude/plugins/marketplaces/vtsls";
              };
            };
          };
        };
      };
    }

    (mkIf cfg.my-plugins.wakatime {
      programs.claude-code = {
        my-settings = {
          enabledPlugins = {
            "claude-code-wakatime@wakatime" = true;
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
    })

    (mkIf cfg.my-plugins.rtk {
      programs.claude-code = {
        my-settings = {
          permissions = {
            allow = [
              "Bash(rtk *)"
            ];
          };
          hooks = {
            PreToolUse = [
              {
                matcher = "Bash";
                hooks = [
                  {
                    type = "command";
                    command = "rtk hook claude";
                  }
                ];
              }
            ];
          };
        };
      };
    })

    (mkIf cfg.my-plugins.caveman {
      programs.claude-code = {
        my-settings = {
          enabledPlugins = {
            "caveman@caveman" = true;
          };
          extraKnownMarketplaces = {
            caveman = {
              source = {
                source = "github";
                repo = "JuliusBrussee/caveman";
              };
            };
          };
        };
      };
    })

    {
      home.activation = mkMerge [
        (mkIf (cfg.my-settings != {}) {
          claudeCodeConfig =
            lib.hm.dag.entryAfter ["linkGeneration"]
            (mylib.mkJSONMutableConfig {
              value = cfg.my-settings;
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
    }

    {
      home.file = {
        ".claude/plugins/marketplaces/vtsls/.claude-plugin/marketplace.json".source = jsonFormat.generate "marketplace.json" {
          "$schema" = "https://anthropic.com/claude-code/marketplace.schema.json";
          name = "vtsls";
          description = "vtsls TypeScript language server for Claude Code";
          owner = {
            name = "local";
          };
          plugins = [
            {
              name = "vtsls-lsp";
              description = "TypeScript/JavaScript language server using vtsls";
              version = "1.0.0";
              source = "./plugins/vtsls-lsp";
              category = "development";
              strict = false;
              lspServers = {
                typescript = {
                  command = "vtsls";
                  args = ["--stdio"];
                  extensionToLanguage = {
                    ".ts" = "typescript";
                    ".tsx" = "typescriptreact";
                    ".js" = "javascript";
                    ".jsx" = "javascriptreact";
                    ".mts" = "typescript";
                    ".cts" = "typescript";
                    ".mjs" = "javascript";
                    ".cjs" = "javascript";
                  };
                };
              };
            }
          ];
        };

        ".claude/plugins/marketplaces/vtsls/plugins/vtsls-lsp/plugin.json".source = jsonFormat.generate "plugin.json" {
          name = "vtsls-lsp";
          description = "TypeScript/JavaScript language server using vtsls";
          author = {name = "local";};
        };
      };
    }
  ]);
}
