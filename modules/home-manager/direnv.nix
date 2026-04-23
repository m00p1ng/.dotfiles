{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.direnv;
in {
  config = mkIf cfg.enable {
    programs.direnv = {
      nix-direnv.enable = true;
      config = {
        global = {
          hide_env_diff = true;
        };
      };
    };

    xdg.configFile."lib/layout_uv.sh".text =
      #sh
      ''
        layout_uv() {
          if [[ -d ".venv" ]]; then
            VIRTUAL_ENV="$(pwd)/.venv"
          fi

          if [[ -z $VIRTUAL_ENV || ! -d $VIRTUAL_ENV ]]; then
            log_status "No uv project exists. Executing \`uv init\` to create one."
            uv init --no-readme
            rm hello.py
            uv venv
            VIRTUAL_ENV="$(pwd)/.venv"
          fi

          PATH_add "$VIRTUAL_ENV/bin"
          export UV_ACTIVE=1 # or VENV_ACTIVE=1
          export VIRTUAL_ENV
        }
      '';
  };
}
