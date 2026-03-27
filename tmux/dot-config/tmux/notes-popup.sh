#!/usr/bin/env bash

CURRENT_SESSION="$(tmux display-message -p '#{session_name}')"

if [[ "${CURRENT_SESSION}" =~ ^_(.*)_popup ]]; then
    tmux detach-client
    exit 0
fi

MAIN_SESSION="${CURRENT_SESSION}"
NOTE_SESSION="_${MAIN_SESSION}_popup"

if tmux has-session -t "${NOTE_SESSION}" 2>/dev/null; then
    tmux popup -w 90%  -h 90% -E "tmux attach -t ${NOTE_SESSION}"
else
    tmux new-session -d -s "${NOTE_SESSION}"
    tmux send-keys -t 0 "nvim .local/NOTES.md" C-m
    tmux set -t "${NOTE_SESSION}" status off
    tmux popup -w 90%  -h 90% -E "tmux attach -t ${NOTE_SESSION}"
fi
