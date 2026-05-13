{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.claude-code;
  jsonFormat = pkgs.formats.json {};

  marketplaceName = "mooping-official";
  marketplaceDir = ".claude/plugins/marketplaces/${marketplaceName}";
  marketplacePath = "${config.home.homeDirectory}/${marketplaceDir}";
in {
  config = mkIf cfg.enable {
    programs.claude-code = {
      my-settings = {
        extraKnownMarketplaces = {
          ${marketplaceName} = {
            source = {
              source = "directory";
              path = marketplacePath;
            };
          };
        };
      };
    };

    home.file = {
      "${marketplaceDir}/.claude-plugin/marketplace.json".source = jsonFormat.generate "marketplace.json" {
        "$schema" = "https://json.schemastore.org/claude-code-marketplace.json";
        name = marketplaceName;
        description = "${marketplaceName} marketplace - local plugins for Claude Code";
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
          {
            name = "basedpyright-lsp";
            description = "Python language server using basedpyright";
            version = "1.0.0";
            source = "./plugins/basedpyright-lsp";
            category = "development";
            strict = false;
            lspServers = {
              python = {
                command = "basedpyright-langserver";
                args = ["--stdio"];
                extensionToLanguage = {
                  ".py" = "python";
                  ".pyi" = "python";
                };
              };
            };
          }
        ];
      };

      "${marketplaceDir}/plugins/vtsls-lsp/plugin.json".source = jsonFormat.generate "plugin.json" {
        name = "vtsls-lsp";
        description = "TypeScript/JavaScript language server using vtsls";
        author = {
          name = "local";
        };
      };

      "${marketplaceDir}/plugins/basedpyright-lsp/plugin.json".source = jsonFormat.generate "basedpyright-plugin.json" {
        name = "basedpyright-lsp";
        description = "Python language server using basedpyright";
        author = {
          name = "local";
        };
      };
    };
  };
}
