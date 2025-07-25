#!/bin/sh

# Load colors
source "$HOME/.config/sketchybar/colors.sh"

if [ "$SENDER" = "front_app_switched" ]; then
    # Get the app icon
    APP_ICON=$($CONFIG_DIR/plugins/icon_map.sh "$INFO")
    
    # If no icon found, use a default one
    if [ -z "$APP_ICON" ] || [ "$APP_ICON" = "" ] || [ "$APP_ICON" = ":default:" ]; then
        APP_ICON=":chevron_right:"  # Default app icon
    fi
    
    sketchybar --set $NAME \
        label="$INFO" \
        icon="$APP_ICON"
fi