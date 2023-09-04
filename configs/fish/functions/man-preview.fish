function man-preivew -a cmd -d 'Nix darwin wrapper'
  mandoc -Tpdf (man -w $cmd) | open -f -a Preview
end

