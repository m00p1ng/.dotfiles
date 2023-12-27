{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.programs.node;
  pnpmPath = "${config.home.homeDirectory}/tools/pnpm";
in {
  options.programs.node = {
    enable = mkEnableOption "node";
    pnpm = {
      enable = mkEnableOption "pnpm";
    };
  };

  config = mkIf cfg.enable (mkMerge([
    {
      home.packages = with pkgs; [
        fnm
      ];

      programs.fish = {
        interactiveShellInit = ''
          # FNM configuration
          fnm env --use-on-cd | source
          fnm completions --shell fish | source
        '';
      };
    }

    (mkIf cfg.pnpm.enable {
      home.packages = with pkgs; [
        nodePackages.pnpm
      ];

      home.sessionVariables = {
        PNPM_HOME = pnpmPath;
      };

      programs.fish = {
        shellAbbrs = {
          pn = "pnpm";
        };
        shellInit = ''
          fish_add_path ${pnpmPath}
        '';
      };
    })
  ]));
}
