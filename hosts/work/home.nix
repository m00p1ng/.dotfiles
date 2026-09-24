{
  pkgs,
  mylib,
  ...
}: {
  home.stateVersion = "26.05";
  imports = mylib.scanPathsRecursive ../../modules/home-manager;

  programs = {
    bat = {
      enable = true;
    };

    direnv = {
      enable = true;
    };

    eza = {
      enable = true;
    };

    fish = {
      enable = true;
    };

    gh = {
      enable = true;
    };

    git = {
      enable = true;
    };

    gvm = {
      enable = true;
    };

    jq = {
      enable = true;
    };

    nix-development = {
      enable = true;
    };

    nix-search-tv = {
      enable = true;
    };

    node = {
      enable = true;
    };

    kubernetes = {
      enable = true;
      stern = {
        enable = true;
      };
      k9s = {
        enable = true;
      };
    };

    python = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    ssh = {
      enable = true;
    };

    tmux = {
      enable = true;
    };

    television = {
      enable = true;
    };

    vscode = {
      enable = false;
    };

    zoxide = {
      enable = true;
    };

    # AI
    claude-code = {
      enable = true;
      my-plugins = {
        rtk = true;
        caveman = true;
        wakatime = true;
        statusline = {
          enable = true;
        };
      };
    };

    codex = {
      enable = true;
    };

    github-copilot-cli = {
      enable = true;
    };

    opencode = {
      enable = false;
    };

    pi-coding-agent = {
      enable = false;
    };

    workmux = {
      enable = true;
    };
  };

  my-config = {
    ghostty = {
      enable = true;
    };

    zed = {
      enable = true;
      settings = {
        agent_servers = {
          "github-copilot-cli" = {
            type = "registry";
          };
        };
      };
    };
  };

  home.packages = with pkgs; [
    curl
    fd
    htop
    fastfetch
    httpie
    mole-cleaner
    numbat
    smartmontools
    pstree
    tree
    wget

    rtk
    hunk
  ];
}
