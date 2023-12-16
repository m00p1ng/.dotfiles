function darwin-apply -a profile -d 'Nix darwin wrapper'
  if not test "$profile"
    echo Please provide configuration profile
    return 1
  end

  argparse 'no-update' -- $argv

  pushd .
  cd ~/.dotfiles
  gunignore ./overridden.nix
  gwip 1> /dev/null

   if not test "$_flag_no_update"
    nix flake update
  end

  darwin-rebuild switch --flake ~/.dotfiles#$profile

  gunwip 1> /dev/null
  gignore ./overridden.nix
  popd
end

