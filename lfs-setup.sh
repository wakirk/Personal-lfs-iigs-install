#!/bin/bash
#Edited on DOS.
 
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
}

setup_term() {
    if [ -n "$TMUX" ]; then
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
        tmux new-session -s "$SESSION" "$0"
        # When $0 exits, tmux will terminate automatically
    fi

    echo "Session Finished."
    exit 0
}


# Put this in your script (e.g., above main_routine)

main_routine () {

bash --noprofile --norc -i


}

setup_term

