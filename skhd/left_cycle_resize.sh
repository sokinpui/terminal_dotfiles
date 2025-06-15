#!/bin/bash

state_file="/tmp/yabai_resize_state" # Using the same state file name

# Initialize state file if it doesn't exist or contains an old value
if [[ ! -f $state_file ]]; then
  echo "set_1_4" >"$state_file"
fi

current_action=$(<"$state_file")

current_focused_window=$(yabai -m query --windows --window | jq '.id')
first_window=$(yabai -m query --windows --window first | jq '.id')

# Focus the first window in the space to apply ratio changes predictably
# For 'space --equalize', focusing a specific window first isn't strictly necessary
# but we do it for consistency before restoring focus.
if [[ "$current_action" != "equalize" ]]; then
  yabai -m window --focus "$first_window" &>/dev/null
fi

next_action=""

case "$current_action" in
"set_1_4")
  yabai -m window --ratio abs:0.25 &>/dev/null
  # For debugging: echo "Set to 1/4"
  next_action="set_1_3"
  ;;
"set_1_3")
  yabai -m window --ratio abs:0.6666 &>/dev/null # Using 0.3333 for 1/3
  # For debugging: echo "Set to 1/3"
  next_action="set_1_2"
  ;;
"set_1_2")
  yabai -m window --ratio abs:0.5 &>/dev/null
  # For debugging: echo "Set to 1/2"
  next_action="equalize"
  ;;
# "equalize")
#   yabai -m space --equalize &>/dev/null
#   # For debugging: echo "Equalized space"
#   next_action="set_1_4"
#   ;;
*)
  # Fallback for unknown state (e.g., old state from previous script version)
  # For debugging: echo "Unknown state: $current_action. Resetting to 1/4."
  yabai -m window --focus "$first_window" &>/dev/null # Ensure first window is focused for ratio
  yabai -m window --ratio abs:0.25 &>/dev/null
  next_action="set_1_3"
  ;;
esac

# Restore focus to the originally focused window
if [[ "$current_focused_window" != "null" ]]; then # Check if a window was focused
  yabai -m window --focus "$current_focused_window" &>/dev/null
fi

# Update the state file
echo "$next_action" >"$state_file"
