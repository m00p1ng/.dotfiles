# ref: https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050
{
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
          ./modules/darwin
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
                ./modules/home-manager/bat.nix
                ./modules/home-manager/fish.nix
                ./modules/home-manager/fnm.nix
                ./modules/home-manager/fzf.nix
                ./modules/home-manager/gh.nix
                ./modules/home-manager/git.nix
                ./modules/home-manager/gnu.nix
                ./modules/home-manager/go.nix
                ./modules/home-manager/htop.nix
                ./modules/home-manager/jq.nix
                ./modules/home-manager/k8s.nix
                ./modules/home-manager/kitty.nix
                ./modules/home-manager/less.nix
                ./modules/home-manager/neovim.nix
                ./modules/home-manager/pnpm.nix
                ./modules/home-manager/python.nix
                ./modules/home-manager/ripgrep.nix
                ./modules/home-manager/ruby.nix
                ./modules/home-manager/ssh.nix
                ./modules/home-manager/tmux.nix
                ./modules/home-manager/vscode.nix
                ./modules/home-manager/yt-dlp.nix
                ./modules/home-manager/zoxide.nix
                ./overriding.nix
              ];

              home.packages = with pkgs; [
                curl
                fd
                gcc
                # hey     # load test
                httpie
                neofetch
                rsync
                # rustup
                smartmontools
                sqlite
                tree
                tree-sitter
                wget
              ];
            };
          }
        ];
      };

      darwinConfigurations.mongkonchai = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          # Main `nix-darwin` config
          ./modules/darwin
          {
            users.users.mongkonchai = {
              name = "mongkonchai";
              home = "/Users/mongkonchai";
            };
          }
          # `home-manager` module
          home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users.mongkonchai = { pkgs, ... }: {
              home.stateVersion = "24.05";
              imports = [
                ./modules/home-manager/bat.nix
                ./modules/home-manager/fish.nix
                ./modules/home-manager/fnm.nix
                ./modules/home-manager/fzf.nix
                ./modules/home-manager/git.nix
                ./modules/home-manager/gh.nix
                ./modules/home-manager/gnu.nix
                ./modules/home-manager/htop.nix
                ./modules/home-manager/jq.nix
                ./modules/home-manager/k8s.nix
                ./modules/home-manager/kitty.nix
                ./modules/home-manager/less.nix
                ./modules/home-manager/neovim.nix
                ./modules/home-manager/ripgrep.nix
                ./modules/home-manager/ssh.nix
                ./modules/home-manager/tmux.nix
                ./modules/home-manager/vscode.nix
                ./modules/home-manager/zoxide.nix
                ./overriding.nix
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
