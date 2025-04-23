{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.python;
  pythonEnv = cfg.package.withPackages (ps:
    with ps; [
      ipython
      pipx
      pynvim
    ]);
in {
  options.programs.python = {
    enable = mkEnableOption "python";
    package = mkOption {
      type = types.package;
      default = pkgs.python313;
      defaultText = literalExpression "pkgs.python312";
      example = literalExpression "pkgs.python3";
      description = ''
        Version of python to install.
      '';
    };
    uv = {
      enable = mkEnableOption "uv";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = [pythonEnv];
    }

    (mkIf cfg.uv.enable {
      home.packages = with pkgs; [
        uv
      ];
    })
  ]);
}
