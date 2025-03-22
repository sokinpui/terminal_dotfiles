#!/bin/bash

state_file="/tmp/yabai_auto_balance_state"

# Initialize state file if it doesn't exist
if [[ ! -f $state_file ]]; then
    echo "off" > $state_file  # Start with clockwise
fi

current_state=$(<"$state_file")


if [[ $current_state == "off" ]]; then
    current_state="on"
else
    current_state="off"
fi


if [[ $current_state == "off" ]]; then
  yabai -m config auto_balance on &> /dev/null
else
  yabai -m config auto_balance off &> /dev/null
fi

echo "$current_state" > "$state_file"

