function darwin-apply -a profile -d 'Nix darwin wrapper'
  if not test "$profile"
    echo "Please provide configuration profile"
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

  sudo darwin-rebuild switch --flake ~/.dotfiles#$profile
  printf "%b\n" "\033[31m\n===== Applied profile: $profile =====\n\033[0m"
  nvd diff (command ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)

  gunwip 1> /dev/null
  gignore ./override.nix
  popd
end

complete -c darwin-apply -n "__fish_use_subcommand" -f -a "mooping work"
