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
      nixpkgs = mkEnableOption "nixpkgs update widget";
      volume = mkEnableOption "Whether to enable the volume widget";
      meeting = {
        enable = mkEnableOption "meeting widget";
        calendars = mkOption {
          type = types.listOf types.str;
          default = [];
          description = "List of calendar names for the meeting widget";
        };
      };
    };
    bar = {
      height = mkOption {
        type = types.int;
        default = 36;
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
        git
        ical-guy
      ];
    };

    launchd.user.agents.sketchybar = {
      serviceConfig.EnvironmentVariables = {
        # The nix-darwin service starts SketchyBar directly, without a shell
        # that supplies HOME. SketchyBar uses HOME to find Home Manager's
        # ~/.config/sketchybar/sketchybarrc.
        HOME = "/Users/${username}";
        SKETCHYBAR_WIDGET_SLACK = boolToString cfg.widget.slack;
        SKETCHYBAR_WIDGET_CURRENCY = boolToString cfg.widget.currency;
        SKETCHYBAR_WIDGET_CPU = boolToString cfg.widget.cpu;
        SKETCHYBAR_WIDGET_MEETING = boolToString cfg.widget.meeting.enable;
        SKETCHYBAR_WIDGET_MEETING_CALENDARS = concatStringsSep "," cfg.widget.meeting.calendars;
        SKETCHYBAR_WIDGET_NIXPKGS = boolToString cfg.widget.nixpkgs;
        SKETCHYBAR_WIDGET_VOLUME = boolToString cfg.widget.volume;
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
