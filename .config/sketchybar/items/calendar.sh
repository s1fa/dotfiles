#!/bin/bash

# Load colors
source "$HOME/.config/sketchybar/colors.sh"

calendar=(
    icon="􀉉"
    icon.font="$FONT_FACE:Bold:16.0"
    icon.color=$PINK
    icon.padding_left=4
    icon.padding_right=4
    label.font="$FONT_FACE:Medium:13.0"
    label.color=$TEXT
    label.padding_left=2
    label.padding_right=8
    background.color=$ITEM_COLOR
    background.corner_radius=6
    background.height=24
    update_freq=30
    script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right \
    --set calendar "${calendar[@]}" \
    --subscribe calendar system_woke
