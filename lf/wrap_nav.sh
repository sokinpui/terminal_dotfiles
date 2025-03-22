#!/bin/bash

# Get the current line number
current_line=$(lf -remote "send $id echo $line")

# Get the total number of lines
total_lines=$(lf -remote "send $id echo $lines")

# Check the direction of navigation
if [ "$1" == "down" ]; then
    if [ "$current_line" -lt "$total_lines" ]; then
        lf -remote "send $id down"
    else
        lf -remote "send $id jump 1"
    fi
elif [ "$1" == "up" ]; then
    if [ "$current_line" -gt 1 ]; then
        lf -remote "send $id up"
    else
        lf -remote "send $id jump $total_lines"
    fi
fi

