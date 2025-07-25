# Load colors
source "$HOME/.config/sketchybar/colors.sh"

sketchybar --add item front_app left \
    --set front_app \
    icon.font="sketchybar-app-font:Regular:16.0" \
    icon.color=$BASE \
    icon.y_offset=0 \
    icon.padding_left=10 \
    icon.padding_right=6 \
    label.font="$FONT_FACE:Semibold:14.0" \
    label.color=$BASE \
    label.y_offset=0 \
    label.padding_left=0 \
    label.padding_right=10 \
    background.color=$BLUE \
    background.corner_radius=6 \
    background.height=24 \
    background.padding_left=6 \
    script="$PLUGIN_DIR/front_app.sh" \
    --subscribe front_app front_app_switched
