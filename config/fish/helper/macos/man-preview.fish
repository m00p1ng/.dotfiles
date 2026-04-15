function man-preview -a cmd -d 'Open man page as PDF in Preview'
  mandoc -Tpdf (man -w $cmd) | open -f -a Preview
end

