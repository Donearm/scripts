#!/bin/sh

tmux new-session -d -s Litecoin -n 'Litecoind' 'litecoind'
tmux split-window -h 'minerd -c /mnt/d/Stuff/cpuminer.json'
#tmux new-window -t Litecoin:1 -n 'Cpuminer' 'minerd -c cpuminer.json'
#tmux select-window -t Litecoin:1
tmux -2 attach-session -t Litecoin
