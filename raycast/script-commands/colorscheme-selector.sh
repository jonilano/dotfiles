#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Colorscheme Selector
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Terminal

# Documentation:
# @raycast.description Terminal colorscheme selector
# @raycast.author jonilano
# @raycast.authorURL https://raycast.com/jonilano


TARGET_DIR="$HOME/dotfiles/colorscheme/themes"
COLORSCHEME_SELECTOR="$HOME/dotfiles/colorscheme/colorscheme-selector.sh"

# SELECTED_FILE=$(osascript <<EOF
# set theFolder to POSIX file "$TARGET_DIR" as alias
#
# tell application "System Events"
# 	set fileList to name of files of theFolder
# end tell
#
# # activate application "System Events"
#
# set userChoice to choose from list fileList with prompt "Select a file from $TARGET_DIR:" without multiple selections allowed
#
# if userChoice is not false then
# 	return item 1 of userChoice
# end if
# EOF
# )

SELECTED_FILE=$(osascript <<EOF
set theFolder to POSIX file "$TARGET_DIR" as alias

tell application "Finder"
#    activate
	set fileList to name of files of folder theFolder
end tell

# tell application "System Events"
# 	tell process "Finder"
# 		set frontmost to true
# 	end tell
# end tell

set userChoice to choose from list fileList with prompt "Select a file from $TARGET_DIR:" without multiple selections allowed
# set userChoice to choose from list fileList with prompt "Select a file from $TARGET_DIR:" without multiple selections allowed default items {item 1 of fileList}

if userChoice is not false then
	return item 1 of userChoice
end if
EOF
)

if [ -n "$SELECTED_FILE" ]; then
	# echo "You selected: $TARGET_DIR/$SELECTED_FILE"
    "$COLORSCHEME_SELECTOR" "$SELECTED_FILE"
else
	echo "No file selected."
fi

