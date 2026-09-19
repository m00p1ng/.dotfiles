{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.node;
in {
  options.programs.node = {
    enable = mkEnableOption "node";
    package = mkOption {
      type = types.package;
      default = pkgs.fnm;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = [cfg.package];

      programs.fish = {
        shellInit =
          #sh
          ''
            # FNM configuration
            ${cfg.package}/bin/fnm env --use-on-cd | source

            # Global npm path
            fish_add_path ${config.home.homeDirectory}/.npm-global/node_modules/.bin
          '';
      };

      xdg.configFile."fish/completions/fnm.fish".source = pkgs.runCommand "fnm.fish" {} ''
        ${cfg.package}/bin/fnm completions --shell fish > $out
      '';
    }
  ]);
}
