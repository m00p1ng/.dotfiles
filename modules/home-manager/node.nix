{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.node;
  pnpmPath = "${config.home.homeDirectory}/tools/pnpm";
in {
  options.programs.node = {
    enable = mkEnableOption "node";
    package = mkOption {
      type = types.package;
      default = pkgs.fnm;
    };
    pnpm = {
      enable = mkEnableOption "pnpm";
      package = mkOption {
        type = types.package;
        default = pkgs.nodePackages.pnpm;
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = [cfg.package];

      programs.fish = {
        interactiveShellInit = ''
          # FNM configuration
          ${cfg.package}/bin/fnm env --use-on-cd | source
          ${cfg.package}/bin/fnm completions --shell fish | source
        '';
      };
    }

    (mkIf cfg.pnpm.enable {
      home.packages = [cfg.pnpm.package];

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
        interactiveShellInit = ''
          # PNPM configuration
          ${cfg.pnpm.package}/bin/pnpm completion fish | source
        '';
      };
    })
  ]);
}
