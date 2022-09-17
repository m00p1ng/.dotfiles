function home_config_apply
  if test (count $argv) != 1
    echo Please provide name
    return 1
  end

  pushd .
  cd ~/.dotfiles
  gunignore ./modules/user.nix
  gwip 1> /dev/null

  nix flake update
  nix flake lock --update-input home-manager
  home-manager switch --flake ~/.dotfiles#$argv[1]

  gunwip 1> /dev/null
  gignore ./modules/user.nix
  popd
end

