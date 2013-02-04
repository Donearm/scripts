#!/bin/bash

# Set up a working environment in a new tmux session for a project. 
# Needs to be run like:
# script <name of the project> <path where the project resides>

if [ $# -lt 2 ];
then
	echo "Usage: "
	echo -e "\ttmux_workon_project.sh <project name> <project directory>"
	exit 1
fi

# Start a new session
tmux new-session -d -n "$1" -s "$1" /bin/bash

# cd into project's path (main pane)
tmux send-keys "cd $2" C-m

# Split vertically 
tmux split-window -h -c "$2"

# Attach the new session
tmux attach-session -t "$1"

exit 0
