#!/bin/sh
#
# Check if ttytter is already running inside tmux and if it's not launch
# it

run_tmux() {
	tmux new-session -d -s TTYtter -n TTYtter 'DISPLAY=:0.0 ttytter -rc=-donearm'
	if [ $? -eq 1 ]
	then
		sleep 20 # wait a bit, internet connection may not be ready
		run_tmux
	else
		tmux select-window -t TTYtter:0 2> /dev/null
		exit 0
	fi
}

run_screen() {
	screen -dm -c ~/.screenrc-ttytter &
	if [ $? -eq 1 ]
	then
		sleep 20 # wait a bit, internet connection may not be ready
		run_screen
	else
		exit 0
	fi
}

# Do we have screen or tmux?
SCREEN=$(hash screen &>/dev/null)
if [ $? -eq 1 ]
then
	# no screen installed, maybe tmux
	TMUX=$(hash tmux &>/dev/null)
	if [ $? -eq 0 ]
	then
		RUNNING=$(tmux has-session -t TTYtter)
		if [ $? -eq 1 ]
		then
			run_tmux
		fi
	else
		echo "No screen or tmux found, exiting..."
		exit 1
	fi
else
	RUNNING=$(screen -q -ls)
	if [ $? -lt 10 ]
	then
		run_screen
	fi
fi

exit 0
