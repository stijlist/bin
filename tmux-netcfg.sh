#!/bin/bash

SESSION=$1
IFACE=$2
if test -z $SESSION; then
  echo "Specify tmux session name:"
  read SESSION
fi

if test -z $IFACE; then
  echo "Choose interface:"
  IFACE="$(choose-iface)"
fi

tmux -2 new-session -d -s "$SESSION"

# tmux new-window -t $SESSION:1 -n "$SESSION"
tmux split-window -h
tmux select-pane -t 1
tmux send-keys "cd ~/fuchsia; sudo ./netcfg.sh $IFACE" Enter
tmux split-window -v
tmux send-keys "fx log" Enter
tmux split-window -v
tmux send-keys "fx boot" Enter
tmux attach -t "$SESSION"
