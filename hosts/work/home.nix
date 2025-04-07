{
  pkgs,
  mylib,
  ...
}: {
  home.stateVersion = "24.11";
  imports = mylib.scanPaths ../../modules/home-manager;

  programs = {
    bat = {
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
      delta = {
        enable = true;
      };
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
      enable = false;
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

    vscode = {
      enable = true;
    };

    zoxide = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    curl
    fd
    htop
    httpie
    fastfetch
    numbat
    smartmontools
    pstree
    tree
    tree-sitter
    wget
  ];
}
