{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.workmux;
in {
  options.programs.workmux.enable = mkEnableOption "workmux";

  config = mkIf cfg.enable {
    # xdg.configFile."workmux/config.yaml".text = ''
    #   merge_strategy: rebase
    #   agent: claude
    #   panes:
    #     - command: <agent>
    #       focus: true
    #     - split: horizontal
    # '';

    programs.fish = {
      shellAbbrs = {
        wm = "workmux";
      };
      interactiveShellInit =
        #sh
        ''
          # workmux configuration
          workmux completions fish | source
        '';
    };
  };
}
