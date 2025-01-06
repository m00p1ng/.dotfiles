{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.python;
  pythonEnv = cfg.package.withPackages (ps: [
    ps.ipython
    ps.pipx
    ps.pynvim
  ]);
in {
  options.programs.python = {
    enable = mkEnableOption "python";
    package = mkOption {
      type = types.package;
      default = pkgs.python312;
      defaultText = literalExpression "pkgs.python312";
      example = literalExpression "pkgs.python3";
      description = ''
        Version of python to install.
      '';
    };
    poetry = {
      enable = mkEnableOption "poetry";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = with pkgs; [
        pythonEnv
        uv
      ];
    }
  ]);
}
