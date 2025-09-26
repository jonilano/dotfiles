#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Tmux Session
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "SessionName" }
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Opens a tmux session
# @raycast.author jonilano
# @raycast.authorURL https://raycast.com/jonilano

# if [ -z "$1" ]; then
#   echo "Usage: $0 <session-name>"
#   exit 1
# fi
#

SESSION_NAME="$1"
KARABINER_DIR="$HOME/dotfiles/karabiner"
DOTFILES_DIR="$HOME/dotfiles"

# Check if the session is "karabiner"
# Karabiner Session
if [ "$SESSION_NAME" = "karabiner" ]; then
  if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    # Start session and create panes
    tmux new-session -d -s "$SESSION_NAME" -c "$KARABINER_DIR"
    tmux send-keys -t "$SESSION_NAME":1.1 "nvim rules.ts" C-m

    tmux split-window -h -t "$SESSION_NAME":1.1 -c "$KARABINER_DIR"
    tmux send-keys -t "$SESSION_NAME":1.2 "yarn run watch" C-m

    tmux select-pane -t "$SESSION_NAME":1.1
  fi

  # Launch Ghostty with tmux attach
  open -na Ghostty --args -e "sh" "-c" "tmux attach -t $SESSION_NAME"

# Dotfiles Session
elif [ "$SESSION_NAME" = "dotfiles" ]; then
  if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux new-session -d -s "$SESSION_NAME" -c "$DOTFILES_DIR"
  fi
  open -na Ghostty --args -e "sh" "-c" "tmux attach -t $SESSION_NAME"

# Generic Session
else
  # Attach to session or create if it doesn't exist
  open -na Ghostty --args -e "sh" "-c" "tmux attach -t $SESSION_NAME || tmux new -s $SESSION_NAME"
fi
