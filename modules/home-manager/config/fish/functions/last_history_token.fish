function last_history_token
    echo $history[1] | read -t -a tokens
    echo $tokens[-1]
end
abbr -a !\$ --position anywhere --function last_history_token
