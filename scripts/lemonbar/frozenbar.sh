#!/usr/bin/zsh

function cleanup {
	kill $workers
	rm -f $panel_fifo

	# Run misc code from the config
	panel_cleanup_misc

	exit
}

function err {
	printf '%s\n' "$*" >&2
}

function use {
	declare dir mod

	mod=$1

	for dir in $modpath; do
		if [[ -f $dir/$mod ]]; then
			if source $dir/$mod; then
				mod::$mod.worker > $panel_fifo &
				workers+=( $! )
				return 0
			else
				err "Module loading failed: $dir/$mod"
				return 3
			fi
		fi
	done
}

function fifo_listen {
	while IFS=$'\0' read -r modname moddata; do
		data[$modname]="$moddata"
		mod::$modname.main
		panel_draw
	done < $panel_fifo
}

function get_rootwin_data {
	while read -r; do
		[[ "$REPLY" =~ "-geometry" ]] && {
			IFS='+' read -r root_win_res _ <<< "${REPLY##* }"
			IFS='x' read -r root_win_w root_win_h <<< "$root_win_res"
		}
	done < <(xwininfo -root)
}

function create_fifo {
	if [[ -e $panel_fifo ]] && {
		if ! rm $panel_fifo; then
			return 1
		fi
	}

	mkfifo $panel_fifo
}

function main {
	# Defines
	declare -A data out

	# XDG
	XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-"/run/user/$UID"}
	XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}

	# Defaults
	cfg_dir="$XDG_CONFIG_HOME/frozenbar"
	cfg_file="$cfg_dir/rc"
	panel_fifo="$XDG_RUNTIME_DIR/frozenbar.fifo"

	modpath=(
		'/usr/lib/frozenbar/mod'
		"$HOME/.config/frozenbar/mod"
	)

	# Handle arguments
	while (( $# )); do
		case $1 in
			(-c) cfg_file=$2; shift;;
			(-f) panel_fifo=$2; shift;;
		esac
		shift
	done

	# load config
	source $cfg_file || {
		return $?
	}

	# Create the fifo or die
	if ! create_fifo; then
		return $?
	fi

	# load mods
	for m in $mods; do
		if ! use $m; then
			return $?
		fi
	done

	panel_pre_start

	fifo_listen | lemonbar -g "$panel_geometry" \
                          -f "$panel_fontspec" \
                          -F "$panel_fg_normal" \
                          -B "$panel_bg_normal" \
                          -n "$panel_window_name" \
                          -a "$panel_clickable_areas" | sh &

	panel_post_start

	wait
}

# Clean up on exit
trap 'cleanup' INT TERM

main $@
