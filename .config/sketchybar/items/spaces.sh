#!/bin/bash

# Load colors
source "$HOME/.config/sketchybar/colors.sh"

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.corner_radius=6 \
        background.height=22 \
        background.drawing=off \
        label="$sid" \
        label.color=$BASE \
        label.font="$FONT_FACE:Bold:14.0" \
        label.padding_left=10 \
        label.padding_right=10 \
        label.x_offset=1 \
        label.y_offset=0 \
        width=30 \
        icon.drawing=off \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done

