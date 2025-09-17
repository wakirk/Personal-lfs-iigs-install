#!/bin/bash
 
echoL() {
	local message="${1:-""}"  # Default to an empty string
	if [ -n "$TMUX" ]; then
		tmux set-option -g status-left "$message"
	else
		echo "$message"
	fi
}

echoR() {
	local message="${1:-""}"  # Default to an empty string
	if [ -n "$TMUX" ]; then
		tmux set-option -g status-right "$message"
	else
		echo "$message"
	fi
}

SetScreen() {
	# Use a dark blue background and bright white text for active panes
	tmux set-option -g window-active-style "bg=darkblue,fg=brightwhite"
	tmux set-option -g status-style "bold,bg=black,fg=brightyellow"
	tmux set-option -g window-status-format ""
	tmux set-option -g window-status-current-format ""
	tmux set-option -g status-left-length 40
	tmux set-option -g status-right-length 40
#    tmux set-window-option -w window-style "bg=default"
#    tmux set-window-option -w window-active-style "bg=darkblue,fg=brightwhite"
    tmux refresh-client -S
	clear
}

setup_term() {
    ensure_tmux_session
#    if [ -n "$TMUX" ]; then
	if [ -n "${TMUX:-}" ] || [ "${LFS_TMUX_BOOTSTRAPPED:-0}" = "1" ]; then
		export LFS_TMUX_BOOTSTRAPPED=1
        # Already inside tmux
        SetScreen
        clear
        echo "*** Setup Script Starting.... ***"
        echoL "Initializing..."
        echoR "Startup"
        
		PS1='\[\e[1;33m\][\u@\h \w]\$\[\e[0m\] '
		export PS1
        main_routine

        # Exit cleanly — don't kill-session from inside
        exit 0
    else
        # Launch new tmux session running this script
        SESSION="my_session"
#       tmux new-session -s "$SESSION" "$0"
        tmux new-session -s "$SESSION" "LFS_TMUX_BOOTSTRAPPED=1 TMUX_SESSION_NAME='$SESSION' '$0'"
        # When $0 exits, tmux will terminate automatically
    fi

    echo "Session Finished."
    exit 0
}

# --- BEGIN: script identity helpers -----------------------------------------
# where_am_I: absolute dir of this script, with symlinks resolved.
where_am_I() {
  # Start from the path Bash used to load this file
  local src="${BASH_SOURCE[0]}"
  # Follow any symlinks
  while [ -h "$src" ]; do
    local dir; dir="$(cd -P -- "$(dirname -- "$src")" && pwd)"
    src="$(readlink -- "$src")"
    [[ "$src" != /* ]] && src="$dir/$src"
  done
  cd -P -- "$(dirname -- "$src")" && pwd
}

# who_am_I: basename of this script (final target if symlinked)
who_am_I() {
  local src="${BASH_SOURCE[0]}"
  while [ -h "$src" ]; do
    local dir; dir="$(cd -P -- "$(dirname -- "$src")" && pwd)"
    src="$(readlink -- "$src")"
    [[ "$src" != /* ]] && src="$dir/$src"
  done
  basename -- "$src"
}

# Export canonical script dir/name for the rest of the file to use.

# --- END: script identity helpers ------------------------------------------

# Put this in your script (e.g., above main_routine)

main_routine () {
    HERE="$(where_am_I)"
    SCRIPT_NAME="$(who_am_I)"
	SetScreen
    export HERE SCRIPT_NAME
	echo "I, $SCRIPT_NAME, amd at $HERE"
	read
	read
	$HERE/test/stage0.sh
#	bash --noprofile --norc -i
}

setup_term

