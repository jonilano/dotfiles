
tmux_reload_config() {
  local file="${1:-$HOME/dotfiles/tmux/tmux-theme}"
  if tmux has-session 2>/dev/null; then
    tmux source-file "$file"
  fi
}

tmux_generate_config() {
  local file="${1:-$HOME/dotfiles/tmux/tmux-theme}"

  cat >"$file" <<EOF
##### STATUS BAR #####
set -g status-style bg=default,fg=white

# Status left and right (styled with inline color codes)
set -g status-left-length 40
set -g status-left "#[bg=green,fg=black,bold] #S #[default] "

set -g status-right-length 60
set -g status-right "#[fg=green]#H #[fg=white]| #[fg=cyan]%a %b %d #[fg=yellow]%I:%M %p"

##### WINDOW TABS #####
# Default window (inactive)
set -g window-status-format " #I:#W "
set -g window-status-style bg=default,fg=grey

# Active window
# set -g window-status-current-format " #[fg=cyan,bold]#I:#W* "
set -g window-status-current-format " #I:#W "
# set -g window-status-current-style bg=blue,fg=white
set -g window-status-current-style bg=#334658,fg=cyan,bold

# Bell in window
set -g window-status-bell-style bg=red,fg=white

# Activity in window (e.g. output in a background window)
set -g window-status-activity-style bg=black,fg=yellow

##### PANE BORDERS #####
set -g pane-border-style fg=grey
set -g pane-active-border-style fg=cyan

##### MESSAGE AREA #####
# Messages displayed (e.g. after hitting a key)
set -g message-style bg=black,fg=green

# Command prompt (after pressing )
set -g message-command-style bg=black,fg=cyan

##### MODE (copy-mode, etc.) #####
# set -g mode-style bg=black,fg=yellow

##### CLOCK MODE #####
# set -g clock-mode-style bg=black,fg=green

##### WINDOW CONTENT (optional) #####
# Background of inactive window panes
# set -g window-style bg=black,fg=default

# Background of the active window pane
# set -g window-active-style bg=black,fg=default

EOF

  # echo "tmux configuration updated at '$file'."
}
