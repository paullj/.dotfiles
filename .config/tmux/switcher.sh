#!/bin/sh
# Pick an existing tmux session via fzf and switch to it.

current=$(tmux display-message -p '#S')

selected=$(tmux list-sessions -F '#{session_last_attached} #{session_name}' 2>/dev/null \
    | sort -rn \
    | cut -d' ' -f2- \
    | awk -v cur="$current" '$0 != cur' \
    | fzf --reverse --no-preview --no-info --no-border)

[ -z "$selected" ] && exit 0
tmux switch-client -t "$selected"
