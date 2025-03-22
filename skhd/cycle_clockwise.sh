#!/bin/bash


state_file="/tmp/yabai_swap_state"

# Initialize state file if it doesn't exist
if [[ ! -f $state_file ]]; then
    echo "1" > $state_file  # Start with clockwise
fi

current_state=$(<"$state_file")

current=$(yabai -m query --windows --window | jq '.id')
first=$(yabai -m query --windows --window first | jq '.id')
last=$(yabai -m query --windows --window last | jq '.id')

# Check if current is first or last
if [[ $current == $first ]]; then
    current_state=1
elif [[ $current == $last ]]; then
    current_state=0
fi

# Perform the swap
if [[ $current_state -eq 1 ]]; then
    yabai -m window $current --swap next &> /dev/null
else
    yabai -m window $current --swap prev &> /dev/null
fi

# Update the state file
echo "$current_state" > "$state_file"
