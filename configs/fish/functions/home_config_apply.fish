function home_config_apply -a profile
  if not test "$profile"
    echo Please provide configuration profile
    return 1
  end

  argparse 'no-update' -- $argv

  pushd .
  cd ~/.dotfiles
  gunignore ./modules/user.nix
  gwip 1> /dev/null

  if not test "$_flag_no_update"
    nix flake update
    nix flake lock --update-input home-manager
  end
  home-manager switch --flake ~/.dotfiles#$profile

  gunwip 1> /dev/null
  gignore ./modules/user.nix
  popd
end
