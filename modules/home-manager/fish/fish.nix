{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.fish;
in {
  config = mkIf cfg.enable {
    programs.fish = {
      shellAliases = {
        "..." = "cd ../..";
        "...." = "cd ../../..";
        mv = "mv -i";

        isodate = "date +%Y-%m-%d";
        isodatetime = "date +\"%Y-%m-%dT%H:%M:%S\"";

        # network
        ip = "curl api.ipify.org";
      };

      shellAbbrs = {
        "-" = "cd -"; # abbr -a -- - 'cd -'
      };

      shellInit = ''
        fish_add_path ~/.nix-profile/bin
        fish_add_path /nix/var/nix/profiles/default/bin
        fish_add_path ~/.local/bin
      '';

      interactiveShellInit = ''
        bind \ep history-token-search-backward
        bind \en history-token-search-forward

        fish_config theme choose mooping
      '';

      plugins = [
        # {
        #   name = "fish-functions";
        #   src = fetchFromGitHub {
        #     owner = "razzius";
        #     repo = "fish-functions";
        #     rev = "11dea7268cecd25d8ec17862917d5dba338af5eb";
        #     hash = "sha256-eyDZaZlqtRPhn08tTFYXthkMhVFX0yN6eXIOMoS6RWk=";
        #   };
        # }
      ];
    };

    xdg.configFile."fish" = {
      source = ../../config/fish;
      recursive = true;
    };
  };
}
