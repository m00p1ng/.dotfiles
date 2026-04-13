# .dotfiles

macOS system configuration managed with [Nix Flakes](https://nixos.wiki/wiki/Flakes), [nix-darwin](https://github.com/LnL7/nix-darwin), and [Home Manager](https://github.com/nix-community/home-manager).

## Structure

```
├── config/          Application configs (fish, ghostty, sketchybar, tmux, k9s, ...)
├── flake.nix        Flake inputs & outputs
├── fonts/           Custom fonts (Menlo Nerd Font, Menlo Powerline)
├── hosts/           Per-host config (mooping, work)
├── lib/             Nix helpers
├── modules/
│   ├── darwin/      macOS system modules (core, preferences, yabai, sketchybar, skhd)
│   └── home-manager/ Program modules (git, neovim, fish, tmux, vscode, ...)
├── override.nix     Host-overridable defaults (git user, editor config)
└── pkgs/            Custom package derivations (icalBuddy)
```

## Install

```sh
# Install Nix
sh <(curl -L https://nixos.org/nix/install)

# Apply configuration
sudo nix --extra-experimental-features 'nix-command flakes' \
  run nix-darwin -- switch --flake ~/.dotfiles#user
```

## Hosts

| Host      | Description      |
|-----------|------------------|
| `mooping` | Personal machine |
| `work`    | Work machine     |

Switch between them by changing the flake target:

```sh
sudo nix --extra-experimental-features 'nix-command flakes' \
  run nix-darwin -- switch --flake ~/.dotfiles#work
```

## Highlights

- **Catppuccin Mocha** theme across ghostty, tmux, git-delta, and sketchybar
- **yabai + skhd + sketchybar** for tiling window management
- **Fish** shell with custom prompt and git integration
- **Neovim** as default editor
- **AI tools**: Claude Code, Gemini CLI, OpenCode
- **Dev stack**: Node (Bun/pnpm), Python (uv), Go, Ruby

## Useful Commands

```sh
$ nix-channel --update                               # Update channels
$ nix-collect-garbage -d                             # Clean old generations
$ sudo nix-store --verify --repair --check-contents  # Verify store

$ nix-build -E 'with import <nixpkgs> { }; callPackage ./package.nix { }'
```

## References
- https://nixos.wiki/wiki/Flakes
- https://github.com/nix-community/home-manager/issues/2995#issuecomment-2067727657
