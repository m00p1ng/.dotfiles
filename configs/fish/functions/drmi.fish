function drmi --description "docker - remove image"
  docker images \
  | sed 1d \
  | fzf -q "$1" --no-sort -m -e --tac --height=20 \
  | awk '{ print $3 }' \
  | xargs -r docker rmi
end
