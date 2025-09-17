#!/bin/bash

# Define the path to the lid state file
LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

lid_state=$(cat "$LID_STATE_FILE" | awk '{print $2}')

# Check the state and print the result
if [ "$lid_state" == "open" ]; then
  hyprctl keyword monitor "eDP-1,1920x1200@60,1440x0,1"
elif [ "$lid_state" == "closed" ]; then
  hyprctl keyword monitor "eDP-1,disable"
else
  echo "unknown"
fi
