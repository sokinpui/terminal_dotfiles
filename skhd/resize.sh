#!/bin/bash

state_file="/tmp/yabai_resize_state"
requested_ratio="$1"

[[ -f "$state_file" ]] || touch "$state_file"
current_ratio=$(<"$state_file")

if [[ "$requested_ratio" == "$current_ratio" ]]; then
  yabai -m space --equalize &>/dev/null
  echo "" >"$state_file"
  exit 0
fi

current_win=$(yabai -m query --windows --window | jq -r '.id' 2>/dev/null)
first_win=$(yabai -m query --windows --window first | jq -r '.id' 2>/dev/null)

if [[ -n "$first_win" && "$first_win" != "null" ]]; then
  yabai -m window --focus "$first_win" &>/dev/null
  yabai -m window --ratio abs:"$requested_ratio" &>/dev/null
fi

if [[ -n "$current_win" && "$current_win" != "null" ]]; then
  yabai -m window --focus "$current_win" &>/dev/null
fi

echo "$requested_ratio" >"$state_file"
