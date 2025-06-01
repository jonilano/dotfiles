#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Send Notification to LGTV
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName LG TV

# Documentation:
# @raycast.description Send notification to LG TV with input box
# @raycast.author jonilano
# @raycast.authorURL https://raycast.com/jonilano

# Ensure lgtv is in the PATH
export PATH="$HOME/.local/bin:$PATH"

# Prompt the user for input
user_input=$(osascript -e 'Tell application "System Events" to display dialog "Enter your message:" default answer ""' -e 'text returned of result')

# If user cancels the dialog, exit
if [ $? -ne 0 ]; then
  echo "User cancelled."
  exit 1
fi

# Send the notification
lgtv --name tv notification "$user_input"
