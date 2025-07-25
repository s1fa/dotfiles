#!/bin/bash

# Load colors
source "$HOME/.config/sketchybar/colors.sh"

sketchybar --add event spotify_change $SPOTIFY_EVENT \
    --add item spotify right \
    --set spotify \
    icon.font="sketchybar-app-font:Regular:13.0" \
    icon.color=$GREEN \
    icon.y_offset=1 \
    icon=":spotify:" \
    icon.padding_left=6 \
    icon.padding_right=2 \
    label="Spotify" \
    label.font="$FONT_FACE:Semibold:12.0" \
    label.color=$SUBTEXT0 \
    label.y_offset=1 \
    label.padding_left=2 \
    label.padding_right=6 \
    label.drawing=yes \
    background.color=$ITEM_COLOR \
    background.corner_radius=6 \
    background.height=24 \
    background.padding_left=4 \
    background.padding_right=4 \
    drawing=off \
    script="$PLUGIN_DIR/spotify.sh" \
    --subscribe spotify spotify_change mouse.clicked
