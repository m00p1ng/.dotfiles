{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.go;
in {
  options.programs.go = {
    gvm = {
      enable = mkEnableOption "gvm fish integration";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.go = {
        goPath = "tools/go";
      };
    }

    (mkIf cfg.gvm.enable {
      programs.fish = {
        plugins = with pkgs; [
          {
            # https://github.com/edc/bass
            name = "bass";
            src = fetchFromGitHub {
              owner = "edc";
              repo = "bass";
              rev = "79b62958ecf4e87334f24d6743e5766475bcf4d0";
              hash = "sha256-3d/qL+hovNA4VMWZ0n1L+dSM1lcz7P5CQJyy+/8exTc=";
            };
          }
        ];
        interactiveShellInit = ''
          set gvm_dir "$HOME/.gvm"

          # Check for bass
          if not functions -q bass
            echo "You need to install the edc/bass plugin"
          end

          # Check GVM default exists
          if test -e $gvm_dir/environments/default
            bass source $gvm_dir/environments/default
          end
        '';
      };
    })
  ]);
}
