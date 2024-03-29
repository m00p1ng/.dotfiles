function __join_space
  if [ "$argv[1]" = "" ]
    echo "$argv[2]"
  else
    echo "$argv[1] $argv[2]"
  end
end

function execution_timer -e fish_postexec
  set -l SEC 1000
  set -l MIN 60000
  set -l HOUR 3600000
  set -l DAY 86400000
  set -l MIN_TIMER (math -s0 "5 * $SEC")
  set -l total_time $CMD_DURATION

  if [ $total_time -lt $MIN_TIMER ]
    return
  end

  set -l days   (math -s0 "$total_time / $DAY")
  set -l hours  (math -s0 "$total_time % $DAY / $HOUR")
  set -l mins   (math -s0 "$total_time % $HOUR / $MIN")
  set -l secs   (math -s0 "$total_time % $MIN / $SEC")
  set -l millis (math -s0 "$total_time % $SEC")

  set -l output ""

  if [ $days -ne 0 ]
    set output "$days"d
  end

  if [ $hours -ne 0 ]
    set output (__join_space $output "$hours"h)
  end

  if [ $mins -ne 0 ]
    set output (__join_space $output "$mins"m)
  end

  if [ $secs -ne 0 ]
    if [ $total_time -lt $MIN ]
      set millis_pretty (printf '%03d' $millis)
      set output (echo "$secs.$millis_pretty"s)
    else
      set output (__join_space $output "$secs"s)
    end
  end

  echo -e "\ntooks $output"
end
