#!/bin/bash

# Load colors
source "$HOME/.config/sketchybar/colors.sh"

# Get current date and time
DATE_TIME=$(date '+%a %d %b  %H:%M')

sketchybar --set $NAME \
    icon="􀉉" \
    label="$DATE_TIME"