#! /bin/zsh
pidfile='/tmp/pidfile'
if [ -s "$pidfile" ]; then
	read -r pid < "$pidfile"
	printf "script is already running with pid; %s\nKilling...\n" "$pid"
	kill "$pid"
	exit 1
fi

