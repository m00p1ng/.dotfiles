## Install NIX
```sh
$ sh <(curl -L https://nixos.org/nix/install)

# Ref: https://nixos.org/download.html#nix-install-macos
```

## nix-darwin
```sh
$ nix --extra-experimental-features 'nix-command flakes' \
  run nix-darwin -- switch --flake ~/.dotfiles#user
```

## Useful script
```sh
$ nix-channel --update
$ nix-collect-garbage -d
$ sudo nix-store --verify --repair --check-contents

$ nix-build -E 'with import <nixpkgs> { }; callPackage ./package.nix { }'
```

## References
- https://nixos.wiki/wiki/Flakes
- https://github.com/nix-community/home-manager/issues/2995#issuecomment-2067727657
