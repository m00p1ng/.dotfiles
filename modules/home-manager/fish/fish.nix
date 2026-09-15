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

      shellInit =
        #sh
        ''
          fish_add_path ~/.nix-profile/bin
          fish_add_path /nix/var/nix/profiles/default/bin
          fish_add_path ~/.local/bin
        '';

      interactiveShellInit =
        #sh
        ''
          bind \ep history-token-search-backward
          bind \en history-token-search-forward

          fish_config theme choose mooping
        '';

      functions = {
        loop = {
          description = "loop <count> <command>";
          body =
            #sh
            ''
              for i in (seq 1 $argv[1])
                eval $argv[2..-1]
              end
            '';
        };
        repeat =
          #sh
          ''
            while true
              $argv
              sleep 1
            end
          '';
        tunnel = {
          argumentNames = ["host" "port"];
          body =
            #sh
            ''
              echo "> ssh -NL $port:$host:$port $host"
              ssh -NL $port:$host:$port $host &
              set ssh_pid $last_pid
              sleep .5
              kill -0 $ssh_pid 2>/dev/null || return
              retry sh -c "nc -z localhost $port 2> /dev/null"
              echo "Opening http://localhost:$port in browser..."
              open http://localhost:$port
              trap "kill $ssh_pid" SIGINT
              echo "Hit CONTROL-C to stop."
              wait $ssh_pid
            '';
        };
      };

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
      source = ../../../config/fish;
      recursive = true;
    };
  };
}
