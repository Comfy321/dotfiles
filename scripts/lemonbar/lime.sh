#! /bin/sh
#
# detail_panel.sh
# displays a lemonbar segment with more detailed sysinfo
#

pidfile='/tmp/pidfile'

if [ -s "$pidfile" ]; then
    read -r pid < "$pidfile"
    printf "script is already running with pid: %s\nKilling ...\n" "$pid"
    kill "$pid"
    exit 1
fi

trap "trap - TERM; rm -v $pidfile;  kill 0" INT TERM QUIT EXIT

echo "$$" > "$pidfile"

geometry='300x22+965+29'

# define the toggle command
command="%{r F- A:./detail_panel.sh:} ? %{A}"

clock () {
    while :; do
        date +"${command} %A, %d %B %H:%M:%S "
        sleep 3
    done &
}

clock | lemonbar -p -g "$geometry" -B "#FF282828" -F "#FFbbbbbb" -f "Envy Code R" \
      | sh &
wait
