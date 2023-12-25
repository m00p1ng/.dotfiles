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

  outputs = { nixpkgs, home-manager, darwin, ... }: {
    darwinConfigurations.m00p1ng = darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      modules = [
        # Main `nix-darwin` config
        ./modules/darwin
        {
          users.users.m00p1ng = {
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
          home-manager.users.m00p1ng = import ./hosts/m00p1ng/home.nix;
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
          home-manager.users.mongkonchai = import ./hosts/mongkonchai/home.nix;
        }
      ];
    };
  };
}
