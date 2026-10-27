#!/bin/sh
# fzf picker to jump between tmux sessions running Claude Code (working ones first).

missing=""
for tool in tmux ps awk sort sed tr cut fzf date; do
    command -v "$tool" >/dev/null 2>&1 || missing="$missing $tool"
done
if [ -n "$missing" ]; then
    printf 'claude_sessions.sh: missing required tool(s):%s\n' "$missing" >&2
    printf 'Press enter to close…'; read -r _
    exit 1
fi

SESSIONS_DIR="${CLAUDE_SESSIONS_DIR:-$HOME/.claude/sessions}"
TAB=$(printf '\t')
ESC=$(printf '\033')
ORANGE="${ESC}[38;5;208m"
DIM="${ESC}[2m"
BOLD="${ESC}[1m"
RESET="${ESC}[0m"
NOW=$(date +%s)
NAME_MAX=22
DESC_MAX=45

# --- ~/.claude/sessions + tty match ---
lines=""
err=""
rc=0
if [ ! -d "$SESSIONS_DIR" ]; then
    err="⚠ $SESSIONS_DIR not found — check claude_sessions.sh"
    rc=1
else
    # Live pids (kill is a builtin: no fork per session file).
    livepids=""
    for f in "$SESSIONS_DIR"/*.json; do
        [ -e "$f" ] || continue
        pid=${f##*/}; pid=${pid%.json}
        case "$pid" in ''|*[!0-9]*) continue ;; esac
        if kill -0 "$pid" 2>/dev/null; then
            livepids="$livepids $pid"
        fi
    done

    lines=$({
        tmux list-panes -a -F 'PANE~~#{pane_tty}~~#{session_name}~~#{window_index}~~#{pane_current_command}~~#{pane_title}' 2>/dev/null
        if [ -n "$livepids" ]; then
            csv=$(echo "$livepids" | tr ' ' ',' | sed 's/^,//')
            ps -o pid=,tty= -p "$csv" 2>/dev/null \
                | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/[[:space:]]\{1,\}/~~/' -e 's/^/TTY~~/'
            for pid in $livepids; do
                while IFS= read -r ln || [ -n "$ln" ]; do
                    printf 'STAT~~%s~~%s\n' "$pid" "$ln"
                done < "$SESSIONS_DIR/$pid.json"
            done
        fi
    } | awk -F'~~' -v tab="$TAB" -v orange="$ORANGE" -v dim="$DIM" -v bold="$BOLD" -v reset="$RESET" \
            -v now="$NOW" -v namemax="$NAME_MAX" -v descmax="$DESC_MAX" '
        function reltime(ms,   d, v) {
            if (ms + 0 <= 0) return ""
            d = now - int(ms / 1000)
            if (d < 0) d = 0
            if (d < 45)     return "just now"
            if (d < 5400)   { v = int((d + 30) / 60);    return v " min"  (v == 1 ? "" : "s") " ago" }
            if (d < 86400)  { v = int((d + 1800) / 3600); return v " hour" (v == 1 ? "" : "s") " ago" }
            v = int((d + 43200) / 86400); return v " day" (v == 1 ? "" : "s") " ago"
        }
        $1 == "PANE" {
            tty = $2; sub(/^\/dev\//, "", tty)
            sess[tty] = $3; win[tty] = $4
            t = $6; for (i = 7; i <= NF; i++) t = t "~~" $i; title[tty] = t
            if ($5 ~ /^[0-9]+\.[0-9]+/) claudepanes++
            next
        }
        $1 == "TTY" { pidtty[$2] = $3; next }
        $1 == "STAT" {
            pid = $2; rest = $0
            if (match(rest, /"status"[ :]*"[^"]*"/)) {
                s = substr(rest, RSTART, RLENGTH); sub(/.*"status"[ :]*"/, "", s); sub(/".*/, "", s)
                status[pid] = s
            }
            if (match(rest, /"statusUpdatedAt"[ :]*[0-9]+/)) {
                u = substr(rest, RSTART, RLENGTH); gsub(/[^0-9]/, "", u); upd[pid] = u
            }
            next
        }
        END {
            n = 0
            maxname = 0
            for (pid in status) {
                tty = pidtty[pid]; if (tty == "" || !(tty in sess)) continue
                s = sess[tty]
                active = (status[pid] == "busy")

                nm = s
                if (length(nm) > namemax) nm = substr(nm, 1, namemax - 3) "..."
                if (length(nm) > maxname) maxname = length(nm)

                tt = title[tty]; sub(/^[^ ]+ +/, "", tt)
                if (length(tt) > descmax) tt = substr(tt, 1, descmax - 3) "..."

                n++
                r_rank[n]   = active ? 0 : 1
                r_upd[n]    = upd[pid] + 0
                r_target[n] = s ":" win[tty]
                r_glyph[n]  = active ? (bold orange "✻" reset) : (dim "•" reset)
                r_name[n]   = nm
                r_rel[n]    = reltime(upd[pid])
                r_tt[n]     = tt
            }
            if (n == 0 && claudepanes > 0) exit 3     # sessions gave nothing but Claude is running => schema change
            for (i = 1; i <= n; i++) {
                printf "%d%s%d%s%s%s%s %-*s  %s%-12s%s  %s%s%s\n", \
                    r_rank[i], tab, r_upd[i], tab, r_target[i], tab, \
                    r_glyph[i], maxname, r_name[i], dim, r_rel[i], reset, dim, r_tt[i], reset
            }
        }
    ')
    rc=$?
    if [ "$rc" -eq 3 ]; then
        err="⚠ ~/.claude/sessions schema changed — check claude_sessions.sh"
    elif [ "$rc" -ne 0 ]; then
        err="⚠ session scan failed (exit $rc) — check claude_sessions.sh"
    fi
fi

# active first (rank asc), then most-recently-updated (order desc)
lines=$(printf '%s\n' "$lines" | sed '/^$/d' | sort -t"$TAB" -k1,1n -k2,2nr)

if [ -n "$err" ]; then
    sel=$(printf '%s\n' "$lines" | fzf --ansi --reverse --no-info --no-border \
            --delimiter="$TAB" --with-nth=4 --header="$err")
else
    sel=$(printf '%s\n' "$lines" | fzf --ansi --reverse --no-info --no-border \
            --delimiter="$TAB" --with-nth=4)
fi

[ -z "$sel" ] && exit 0
target=$(printf '%s' "$sel" | cut -f3)
tmux switch-client -t "$target"
