function darwin-apply -d 'Nix darwin wrapper'
  # Locate this function file and run the sibling scripts/darwin-apply.py
  # so the script is found regardless of the current working directory.
  set -l script (path dirname (path dirname (status -f)))/scripts/darwin-apply.py
  python3 $script $argv
end

complete -c darwin-apply -n "__fish_use_subcommand" -f -a "mooping work"
