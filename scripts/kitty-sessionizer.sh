#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Remote Sessionizer
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "Host", "optional": false }

HOST="$1"

if [ -z "$HOST" ]; then
  exit 1
fi

COMMAND="kitten ssh -t \"$HOST\" \"zsh -l -i -c 'tmux-sessionizer'\"; exec \${SHELL} -l"
SOCKET="${KITTY_LISTEN_ON:-unix:/tmp/kitty}"

if kitten @ --to "$SOCKET" launch --type=tab bash -c "$COMMAND" 2>/dev/null; then
  exit 0
fi

kitty --single-instance bash -c "$COMMAND"
