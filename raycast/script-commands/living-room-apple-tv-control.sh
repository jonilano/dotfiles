#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Living Room Apple TV Control
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "toggleplay" }
# @raycast.packageName Home Automation

# Documentation:
# @raycast.description Living Room Apple TV Control
# @raycast.author jonilano
# @raycast.authorURL https://raycast.com/jonilano
#
# arguments: toggleplay, previous, next, play, pause, turnoff, turnon

WEBHOOK_URL="http://192.168.5.20:8123/api/webhook/livingroom_appletv_$1"
curl -X POST "$WEBHOOK_URL" >/dev/null 2>&1

