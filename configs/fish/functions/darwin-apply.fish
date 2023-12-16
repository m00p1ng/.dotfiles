function darwin-apply -a profile -d 'Nix darwin wrapper'
  if not test "$profile"
    echo Please provide configuration profile
    return 1
  end

  pushd .
  cd ~/.dotfiles
  gunignore ./overridden.nix
  gwip 1> /dev/null

  /run/current-system/sw/bin/darwin-rebuild switch --flake ~/.dotfiles#$profile

  gunwip 1> /dev/null
  gignore ./overridden.nix
  popd
end

