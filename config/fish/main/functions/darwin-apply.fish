function darwin-apply -a profile -d 'Nix darwin wrapper'
  if not test "$profile"
    echo Please provide configuration profile
    return 1
  end

  argparse 'update' -- $argv

  pushd .
  cd ~/.dotfiles
  gunignore ./override.nix
  gwip 1> /dev/null

  if test "$_flag_update"
    nix flake update
  end

  darwin-rebuild switch --flake ~/.dotfiles#$profile

  gunwip 1> /dev/null
  gignore ./override.nix
  popd
end

