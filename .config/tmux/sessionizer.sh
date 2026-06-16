#!/bin/sh
# List existing tmux sessions + git repos in search dirs, pick via fzf,
# then switch to existing session or create a new one in the repo dir.

TAB=$(printf '\t')
current=$(tmux display-message -p '#S')

sessions=$(tmux list-sessions -F '#{session_last_attached} #{session_name}' 2>/dev/null \
    | sort -rn \
    | cut -d' ' -f2- \
    | awk -v cur="$current" -v t="$TAB" '$0 != cur { print $0 t }')

repos=$(find "$HOME/Projects/paullj" "$HOME/Projects/automata-tech" \
        -maxdepth 2 -name .git -type d -prune 2>/dev/null \
    | sed 's|/.git$||' \
    | awk -F/ -v t="$TAB" '{ print $NF t $0 }')

selected=$(printf '%s\n%s\n' "$sessions" "$repos" \
    | awk -F"$TAB" 'NF && !seen[$1]++' \
    | fzf --reverse --no-preview --no-info --no-border \
          --delimiter="$TAB" --with-nth=1)

[ -z "$selected" ] && exit 0

name=${selected%%	*}
path=${selected#*	}
[ "$path" = "$name" ] && path=""

if tmux has-session -t="$name" 2>/dev/null; then
    tmux switch-client -t "$name"
else
    tmux new-session -ds "$name" -c "$path"
    tmux switch-client -t "$name"
fi
