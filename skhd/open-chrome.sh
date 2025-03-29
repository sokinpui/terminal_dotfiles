#!/bin/bash

# Get the current focused window's display and space
focused_window=$(yabai -m query --windows --window)
current_space=$(echo "$focused_window" | jq '.space')
current_display=$(echo "$focused_window" | jq '.display')

# Focus the target display and space
# Open a new Chrome window

open -na "Google Chrome" --args --new-window

new_tab_id=$(yabai -m query --windows | jq -r '.[] | select(.app == "Google Chrome" and .title == "New Tab - Google Chrome") | .id ')

sleep 0.3

yabai -m window --focus "$new_tab_id" && yabai -m window --display "$current_display"


