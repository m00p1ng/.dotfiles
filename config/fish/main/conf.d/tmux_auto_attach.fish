# auto attach tmux configuration
status is-interactive; and begin
  if [ "$TERM_PROGRAM" != "ghostty" ] || set -q TMUX
    return
  end

  set tmux_default_session_name workspace
  set tmux_attached_client (tmux list-clients 2> /dev/null | grep $tmux_default_session_name | wc -l)
  set tmux_has_default_session (tmux ls 2> /dev/null | grep $tmux_default_session_name | wc -l)

  if [ $tmux_attached_client -ne 0 ]
    tmux
  else if [ $tmux_has_default_session -eq 0 ]
    tmux new -s $tmux_default_session_name
  else
    tmux a -t $tmux_default_session_name
  end
end
