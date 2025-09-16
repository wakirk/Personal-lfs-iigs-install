#  **************************************************************************
#  *                                                                        *
#  *                          Terminal Control.                             *
#  *                                                                        *
#  **************************************************************************

# Function to set the left side of the tmux status bar or echo the message if not in tmux
echoL() {
    local message="${1:-""}"  # Default to an empty string
    if [ -n "$TMUX" ]; then
        tmux set-option -g status-left "$message"
    else
        echo "$message"
    fi
}


# Function to set the right side of the tmux status bar or echo the message if not in tmux
echoR() {
    local message="${1:-""}"  # Default to an empty string
    if [ -n "$TMUX" ]; then
        tmux set-option -g status-right "$message"
    else
        echo "$message"
    fi
}

SetScreen() {
    # Update the left side
    # Set the default pane colors
    # Use a dark blue background and bright white text for panes
    tmux set-option -g window-active-style "bg=darkblue,fg=brightwhite"
    tmux set-option -g status-style "bold,bg=black,fg=brightyellow"
    tmux set-option -g window-status-format ""
    tmux set-option -g window-status-current-format ""
    tmux set-option -g status-left-length 40
    tmux set-option -g status-right-length 40
}

