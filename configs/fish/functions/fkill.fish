function fkill --description "kill process"
  set -l pid ''
  set -l uid (id | cut -f1 -d' ' | grep -oe '[0-9]*')

  if [ "$uid" != "0" ]
    set pid (ps -f -u $uid | sed 1d | fzf --height=22 -m -e | awk '{print $2}')
  else
    set pid (ps -ef | sed 1d | fzf --height=22 -m -e | awk '{print $2}')
  end

  if [ "x$pid" != "x" ]
    echo $pid | xargs kill
    echo "kill: $pid"
  end
end
