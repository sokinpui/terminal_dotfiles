#!/bin/bash

state_file="/tmp/yabai_resize_state"

# Initialize state file if it doesn't exist
if [[ ! -f $state_file ]]; then
    echo "resize" > $state_file  # Start with clockwise
fi

current_state=$(<"$state_file")

# Perform the swap
if [[ $current_state == "resize" ]]; then
  current=$(yabai -m query --windows --window | jq '.id')
  first=$(yabai -m query --windows --window first | jq '.id')
  yabai -m window --focus $first
  yabai -m window --ratio abs:$1 &> /dev/null
  yabai -m window --focus $current
  current_state="equalize"
else
  yabai -m space --equalize
  current_state="resize"
fi

echo "$current_state" > "$state_file"

