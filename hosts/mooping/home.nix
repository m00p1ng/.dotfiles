{
  pkgs,
  mylib,
  ...
}: {
  home.stateVersion = "25.11";
  imports = mylib.scanPathsRecursive ../../modules/home-manager;

  programs = {
    bat = {
      enable = true;
    };

    bun = {
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

    fzf = {
      enable = true;
    };

    gh = {
      enable = true;
    };

    ghostty-config = {
      enable = true;
    };

    git = {
      enable = true;
    };

    go = {
      enable = true;
    };

    htop = {
      enable = true;
    };

    jq = {
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

    nix-development = {
      enable = true;
    };

    node = {
      enable = true;
    };

    python = {
      enable = true;
      uv = {
        enable = true;
      };
    };

    ripgrep = {
      enable = true;
    };

    ruby = {
      enable = true;
    };

    sqlit = {
      enable = true;
    };

    ssh = {
      enable = true;
      matchBlocks = {
        "*" = {
          identityFile = "~/.ssh/mooping-macbook";
        };
      };
    };

    television = {
      enable = true;
    };

    tmux = {
      enable = true;
    };

    vscode = {
      enable = false;
      package = pkgs.vscodium;
    };

    yt-dlp = {
      enable = true;
    };

    zed-editor = {
      enable = true;
      userSettings = {
        agent_servers = {
          gemini = {
            type = "registry";
          };
          "github-copilot-cli" = {
            type = "registry";
          };
        };
      };
    };

    zoxide = {
      enable = true;
      excludeDirs = [
        "\$HOME/Library/*"
        "\$HOME/Downloads/*"
      ];
    };

    # AI
    claude-code = {
      enable = true;
      my-plugins = {
        rtk = true;
        caveman = true;
        statusline = {
          enable = true;
        };
      };
    };

    gemini-cli = {
      enable = true;
    };

    opencode = {
      enable = true;
      # my-settings = {
      #   provider = {
      #     lmstudio = {
      #       npm = "@ai-sdk/openai-compatible";
      #       name = "LM Studio (local)";
      #       options = {
      #         baseURL = "http://127.0.0.1:1234/v1";
      #       };
      #       models = {
      #         "qwen3-coder-30b-a3b-instruct-mlx" = {
      #           name = "Qwen3 Coder (local)";
      #         };
      #       };
      #     };
      #   };
      # };
    };
  };

  home.packages = with pkgs; [
    curl
    fd
    # hey     # load test
    htop
    httpie
    fastfetch
    numbat
    presenterm
    rsync
    rustup
    smartmontools
    sqlite
    tree
    wget

    github-copilot-cli
    llama-cpp
    llmfit
  ];
}
