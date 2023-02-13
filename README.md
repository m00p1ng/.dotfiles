## Install NIX
```sh
$ sh <(curl -L https://nixos.org/nix/install)

# Ref: https://nixos.org/download.html#nix-install-macos
```

## Home Manager
```sh
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update

$ export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

$ nix-shell '<home-manager>' -A install


$ sudo cat experimental-features = nix-command flakes >> /etc/nix/nix.conf

$ nix flake update

$ home-manager switch --flake '~/.dotfiles#mooping'
```

## Useful script
```sh
$ nix-channel --update
$ nix-collect-garbage -d
$ home-manager generations
$ sudo nix-store --verify --repair --check-contents
```
## Fish add path
```sh
$ fish_add_path ~/.nix-profile/bin
$ fish_add_path /nix/var/nix/profiles/default/bin
```
## fix touch id on tmux
```sh
$ sudo vim /etc/pam.d/sudo

paste

auth       optional       $HOME/.nix-profile/lib/pam/pam_reattach.so
auth       sufficient     pam_tid.so
```
