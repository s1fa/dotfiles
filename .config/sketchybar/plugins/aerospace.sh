#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

# Load colors
source "$HOME/.config/sketchybar/colors.sh"

# Get the workspace ID from the argument
WORKSPACE_ID="$1"

# Check if this workspace is the currently focused one
if [ "$WORKSPACE_ID" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME \
        background.drawing=on \
        background.color=$PEACH \
        label.color=$BASE \
        icon.color=$BASE
else
    sketchybar --set $NAME \
        background.drawing=off \
        background.color=$TRANSPARENT \
        label.color=$TEXT \
        icon.color=$TEXT
fi

