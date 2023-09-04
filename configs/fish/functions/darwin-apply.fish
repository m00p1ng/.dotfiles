function darwin-apply -a profile -d 'Nix darwin wrapper'
  if not test "$profile"
    echo Please provide configuration profile
    return 1
  end

  pushd .
  cd ~/.dotfiles
  gwip 1> /dev/null

  /run/current-system/sw/bin/darwin-rebuild switch --flake ~/.dotfiles/darwin#$profile

  gunwip 1> /dev/null
  popd
end

