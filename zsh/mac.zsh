# enable Macbook Pro's Touch ID for sudo
# function sudotouchid () {
#  if ! /usr/bin/grep -Fq "pam_tid.so" /etc/pam.d/sudo
#  then
#  /usr/bin/osascript -e 'do shell script "/usr/bin/sed -i '' -e \"1s/^//p; 1s/^.*/auth       sufficient     pam_tid.so/\" /etc/pam.d/sudo" with administrator privileges'
#  fi
# }
# sudotouchid

alias yt-l='youtube-dl -o "%(title)s.%(ext)s"'
alias icloud='cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs'
