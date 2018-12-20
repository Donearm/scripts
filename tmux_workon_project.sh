#!/bin/sh

# Set up a working environment in a new tmux session for a project.
# Needs to be run like:
# script <name of the project> <path where the project resides>

if [ $# -lt 1 ];
then
	echo "Usage: "
	echo -e "\ttmux_workon_project.sh <project directory>"
	exit 1
fi

TARGET_DIR="$@"
TARGET_NAME=$(basename "$TARGET_DIR")

# Start a new session
tmux new-session -d -s "$TARGET_NAME" -n "$TARGET_DIR" /bin/bash

# cd into project's path (main pane)
tmux send-keys "cd $TARGET_DIR" C-m

# Split vertically
tmux split-window -h -c "#{pane_current_path}" 

# Attach the new session
tmux attach-session -t "$TARGET_NAME"

exit 0
