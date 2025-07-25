#!/bin/bash

# Load colors
source "$HOME/.config/sketchybar/colors.sh"

volume=(
  icon.font="$FONT_FACE:Bold:16.0"
  icon.color=$MAUVE
  icon.padding_left=4
  icon.padding_right=4
  label.font="$FONT_FACE:Semibold:13.0"
  label.color=$TEXT
  label.padding_left=2
  label.padding_right=8
  background.color=$ITEM_COLOR
  background.corner_radius=6
  background.height=24
  script="$PLUGIN_DIR/volume.sh"
)

sketchybar --add item volume right \
           --set volume "${volume[@]}" \
           --subscribe volume volume_change
