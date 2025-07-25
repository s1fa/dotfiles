#!/bin/bash

# Load colors
source "$HOME/.config/sketchybar/colors.sh"

# Get battery percentage and charging status
PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

# Set icon based on percentage and charging status
if [ $PERCENTAGE = "" ]; then
  exit 0
fi

if [[ $CHARGING != "" ]]; then
  ICON="􀢋"
  COLOR=$GREEN
elif [ $PERCENTAGE -gt 80 ]; then
  ICON="􀛨"
  COLOR=$GREEN
elif [ $PERCENTAGE -gt 60 ]; then
  ICON="􀺸"
  COLOR=$YELLOW
elif [ $PERCENTAGE -gt 40 ]; then
  ICON="􀺶"
  COLOR=$YELLOW
elif [ $PERCENTAGE -gt 20 ]; then
  ICON="􀛩"
  COLOR=$PEACH
else
  ICON="􀛪"
  COLOR=$RED
fi

sketchybar --set $NAME \
    icon="$ICON" \
    icon.color=$COLOR \
    label="${PERCENTAGE}%"
