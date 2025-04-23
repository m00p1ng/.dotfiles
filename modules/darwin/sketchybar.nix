{
  config,
  lib,
  pkgs,
  username,
  ...
}:
with lib; let
  cfg = config.services.sketchybar;
in {
  options.services.sketchybar = {
    widget = {
      slack = mkEnableOption "slack widget";
      currency = mkEnableOption "currency widget";
      cpu = mkEnableOption "cpu widget";
      meeting = mkEnableOption "meeting widget";
    };
    bar = {
      height = mkOption {
        type = types.int;
        default = 28;
        description = "Height of the SketchyBar bar";
      };
    };
  };
  config = mkIf cfg.enable {
    system.defaults.NSGlobalDomain._HIHideMenuBar = true;
    services = {
      yabai.config.external_bar = "all:${toString cfg.bar.height}:0";

      sketchybar.extraPackages = with pkgs; [
        jq
        icalBuddy
      ];
    };

    launchd.user.agents.sketchybar = {
      serviceConfig.EnvironmentVariables = {
        SKETCHYBAR_WIDGET_SLACK = boolToString cfg.widget.slack;
        SKETCHYBAR_WIDGET_CURRENCY = boolToString cfg.widget.currency;
        SKETCHYBAR_WIDGET_CPU = boolToString cfg.widget.cpu;
        SKETCHYBAR_WIDGET_MEETING = boolToString cfg.widget.meeting;
        SKETCHYBAR_BAR_HEIGHT = toString cfg.bar.height;
      };
    };

    home-manager.users.${username} = {
      xdg.configFile."sketchybar" = {
        source = ../../config/sketchybar;
        recursive = true;
      };
    };
  };
}
