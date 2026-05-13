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
        "$schema" = "https://anthropic.com/claude-code/marketplace.schema.json";
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
        ];
      };

      "${marketplaceDir}/plugins/vtsls-lsp/plugin.json".source = jsonFormat.generate "plugin.json" {
        name = "vtsls-lsp";
        description = "TypeScript/JavaScript language server using vtsls";
        author = {
          name = "local";
        };
      };
    };
  };
}
