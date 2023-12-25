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
    darwinConfigurations = {
      m00p1ng = let
        username = "m00p1ng";
      in darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          home-manager.darwinModules.home-manager
          ./modules/darwin
          {
            home-manager = {
              users.${username} = import ./hosts/m00p1ng/home.nix;
            };
          }
        ];
        specialArgs = { inherit username; };
      };

      mongkonchai = let
        username = "mongkonchai";
      in darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          home-manager.darwinModules.home-manager
          ./modules/darwin
          {
            home-manager = {
              users.${username} = import ./hosts/mongkonchai/home.nix;
            };
          }
        ];
        specialArgs = { inherit username; };
      };
    };
  };
}
