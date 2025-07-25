#!/bin/bash

# Load colors
source "$HOME/.config/sketchybar/colors.sh"

battery=(
    icon.font="$FONT_FACE:Bold:16.0"
    icon.color=$GREEN
    icon.padding_left=4
    icon.padding_right=4
    label.font="$FONT_FACE:Semibold:13.0"
    label.color=$TEXT
    label.padding_left=0
    label.padding_right=8
    background.color=$ITEM_COLOR
    background.corner_radius=6
    background.height=24
    update_freq=120
    script="$PLUGIN_DIR/battery.sh"
)

sketchybar --add item battery right \
    --set battery "${battery[@]}" \
    --subscribe battery system_woke power_source_change
