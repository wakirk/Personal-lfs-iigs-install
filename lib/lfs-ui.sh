# lfs-ui.sh — screen/tmux + location helpers (source-able)
# Keep menus clean: source this file in any script, then:
#   lfs_identity
#   lfs_tmux_entry main_routine
#
# Exports:
#   HERE, SCRIPT_NAME, LFS_TMUX_BOOTSTRAPPED (sentinel)
#
# NOTE: No output suppression; stick to your environment/style.

# where_am_I: absolute dir of the current script, with symlinks resolved.
where_am_I() {
	local src="${BASH_SOURCE[1]:-${BASH_SOURCE[0]}}"
	while [ -h "$src" ]; do
		local dir; dir="$(cd -P -- "$(dirname -- "$src")" && pwd)"
		src="$(readlink -- "$src")"
		[[ "$src" != /* ]] && src="$dir/$src"
	done
	cd -P -- "$(dirname -- "$src")" && pwd
}

# who_am_I: basename of the current script (final target if symlinked)
who_am_I() {
	local src="${BASH_SOURCE[1]:-${BASH_SOURCE[0]}}"
	while [ -h "$src" ]; do
		local dir; dir="$(cd -P -- "$(dirname -- "$src")" && pwd)"
		src="$(readlink -- "$src")"
		[[ "$src" != /* ]] && src="$dir/$src"
	done
	basename -- "$src"
}

# lfs_identity: export canonical HERE and SCRIPT_NAME for the caller.
lfs_identity() {
	HERE="$(where_am_I)"
	SCRIPT_NAME="$(who_am_I)"
	export HERE SCRIPT_NAME
}

# echoL/echoR: write to tmux status or stdout if not in tmux.
echoL() {
	local message="${1:-""}"
	if [ -n "$TMUX" ]; then
		tmux set-option -g status-left "$message"
	else
		echo "$message"
	fi
}

echoR() {
	local message="${1:-""}"
	if [ -n "$TMUX" ]; then
		tmux set-option -g status-right "$message"
	else
		echo "$message"
	fi
}

# SetScreen: keep your original styling intact.
SetScreen() {
	# Use a dark blue background and bright white text for active panes
	tmux set-option -g window-active-style "bg=darkblue,fg=brightwhite"
	tmux set-option -g status-style "bold,bg=black,fg=brightyellow"
	tmux set-option -g window-status-format ""
	tmux set-option -g window-status-current-format ""
	tmux set-option -g status-left-length 40
	tmux set-option -g status-right-length 40
}

# lfs__in_tmux: true if $TMUX points to a live server.
lfs__in_tmux() {
	if [ -n "${TMUX:-}" ]; then
		local sock="${TMUX%%,*}"
		tmux -S "$sock" has-session >/dev/null 2>&1 && return 0
	fi
	return 1
}

# lfs_tmux_entry <main_func>
# - If already in tmux (or bootstrapped), style and run <main_func>.
# - Else, create a session and re-run this script inside it, with a sentinel.
lfs_tmux_entry() {
	local entry="${1:-main_routine}"

	if lfs__in_tmux || [ "${LFS_TMUX_BOOTSTRAPPED:-0}" = "1" ]; then
		export LFS_TMUX_BOOTSTRAPPED=1
		SetScreen
		clear
		echo "*** Setup Script Starting.... ***"
		echoL "Initializing..."
		echoR "Startup"
		PS1='\[\e[1;33m\][\u@\h \w]\$\[\e[0m\] '
		export PS1
		"$entry"
		return $?
	fi

	# Create a new session and run this script inside it.
	local sess="${TMUX_SESSION_NAME:-${SCRIPT_NAME%.sh}}"
	[ -n "$sess" ] || sess="lfs-setup"
	sess="${sess//[^A-Za-z0-9_.-]/_}"

	# Re-run the top-level script ($0) inside tmux; preserve spaces by quoting.
	tmux new-session -s "$sess" "LFS_TMUX_BOOTSTRAPPED=1 TMUX_SESSION_NAME=$sess \"$0\""
}
