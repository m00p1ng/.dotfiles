function drm -d "docker - remove container"
  docker ps -a \
  | sed 1d \
  | fzf -q "$1" --no-sort -m -e --tac --height=20 \
  | awk '{ print $1 }' \
  | xargs -r docker rm
end
