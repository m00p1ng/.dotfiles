{
  # ref: https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050
  description = "Home Manager configuration of Mooping";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, darwin, ... }:
    {
      darwinConfigurations.m00p1ng = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          # Main `nix-darwin` config
          ./darwin/configuration.nix
          ./darwin/pam.nix
          {
            users.users.m00p1ng = {
              name = "m00p1ng";
              home = "/Users/m00p1ng";
            };
          }
          # `home-manager` module
          home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users.m00p1ng = { pkgs, ... }: {
              home.stateVersion = "24.05";
              imports = [
                ./modules/bat.nix
                # ./modules/browsh.nix
                ./modules/fish.nix
                ./modules/fnm.nix
                ./modules/fzf.nix
                ./modules/gh.nix
                ./modules/git.nix
                ./modules/gnu.nix
                ./modules/go.nix
                ./modules/htop.nix
                ./modules/jq.nix
                ./modules/k8s.nix
                ./modules/kitty.nix
                ./modules/less.nix
                ./modules/neovim.nix
                ./modules/pnpm.nix
                ./modules/python.nix
                ./modules/ripgrep.nix
                ./modules/ruby.nix
                ./modules/ssh.nix
                ./modules/tmux.nix
                ./modules/vscode.nix
                ./modules/yt-dlp.nix
                ./modules/zoxide.nix
                ./overridden.nix
              ];

              home.packages = with pkgs; [
                awscli
                # cocoapods
                curl
                fd
                gcc
                # hey     # load test
                httpie
                neofetch
                # nmap
                # pstree
                rsync
                # rustup
                smartmontools
                sqlite
                # terraform
                tree
                tree-sitter
                wget
                # yarn
              ];
            };
          }
        ];
      };

      darwinConfigurations.mongkonchai = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          # Main `nix-darwin` config
          ./darwin/configuration.nix
          {
            users.users.mongkonchai = {
              name = "mongkonchai";
              home = "/Users/mongkonchai";
            };
          }
          # `home-manager` module
          home-manager.darwinModules.home-manager
          {
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users.mongkonchai = { pkgs, ... }: {
              home.stateVersion = "24.05";
              imports = [
                ./modules/bat.nix
                ./modules/fish.nix
                ./modules/fnm.nix
                ./modules/fzf.nix
                ./modules/git.nix
                ./modules/gh.nix
                ./modules/gnu.nix
                ./modules/htop.nix
                ./modules/jq.nix
                ./modules/k8s.nix
                ./modules/kitty.nix
                ./modules/less.nix
                ./modules/neovim.nix
                ./modules/ripgrep.nix
                ./modules/ssh.nix
                ./modules/tmux.nix
                ./modules/vscode.nix
                ./modules/zoxide.nix
                ./overridden.nix
              ];

              home.packages = with pkgs; [
                curl
                fd
                gcc
                httpie
                neofetch
                smartmontools
                pstree
                tree
                tree-sitter
                wget
              ];
            };
          }
        ];
      };
    };
}
