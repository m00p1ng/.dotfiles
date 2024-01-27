{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.programs.kubernetes;
in {
  options.programs.kubernetes = {
    enable = mkEnableOption "kubernetes";
    package = mkOption {
      type = types.package;
      default = pkgs.kubectl;
    };
    stern = {
      enable = mkEnableOption "stern";
      package = mkOption {
        type = types.package;
        default = pkgs.stern;
      };
    };
    k9s = {
      enable = mkEnableOption "k9s";
      package = mkOption {
        type = types.package;
        default = pkgs.k9s;
      };
    };
  };

  config = mkIf cfg.enable (mkMerge([
    {
      home.packages = [ cfg.package ];

      programs.fish = {
        shellAliases = {
          k = "kubectl";
        };
      };
    }

    (mkIf cfg.stern.enable {
      home.packages = [ cfg.stern.package ];

      xdg.configFile."stern/config.yaml".text = ''
        exclude-container: istio
        exclude: Healthcheck
        template: '{{color .PodColor .PodName}} {{.Message}}{{"\n"}}'
      '';
    })

    (mkIf cfg.k9s.enable {
      home.packages = [ cfg.k9s.package ];

      xdg.configFile.k9s = {
        source = ../../config/k9s;
        recursive = true;
      };
    })
  ]));
}
