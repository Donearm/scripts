#!/bin/bash

# Set-up Tmux windows for a website project (usually then open
# index.html, main.css and main.js files)

if [ $# -lt 1 ];
then
	echo "Usage: "
	echo -e "\ttmux_sites_projects.sh <project directory>"
	exit 1
fi

TARGET_DIR="$@"
TARGET_NAME=$(basename "$TARGET_DIR")
TMUX=

tmux new -d -s "$TARGET_NAME" -c "$TARGET_DIR"
tmux new-window -d -c "#{pane_current_path}" "vim ${TARGET_DIR}index.html"
tmux select-window -t "$TARGET_NAME":1
tmux rename-window "HTML"
tmux new-window -d  -c "#{pane_current_path}" "vim ${TARGET_DIR}js/main.js"
tmux select-window -t "$TARGET_NAME":2
tmux rename-window "JS"
tmux new-window -d  -c "#{pane_current_path}" "vim ${TARGET_DIR}css/main.css"
tmux select-window -t "$TARGET_NAME":3
tmux rename-window "CSS"
tmux -2 attach-session -t "$TARGET_NAME"
