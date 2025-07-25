#!/usr/bin/env bash

# Load colors
source "$HOME/.config/sketchybar/colors.sh"

# Configuration
readonly MAX_LENGTH=35
readonly HALF_LENGTH=$(((MAX_LENGTH + 1) / 2))

# Utility functions
is_spotify_running() {
    pgrep -x "Spotify" >/dev/null 2>&1
}

truncate_text() {
    local text="$1"
    local max_len="$2"

    if [[ ${#text} -gt $max_len ]]; then
        echo "${text:0:$((max_len - 1))}…"
    else
        echo "$text"
    fi
}

calculate_truncation() {
    local track="$1"
    local artist="$2"
    local track_len=${#track}
    local artist_len=${#artist}

    if [[ $((track_len + artist_len)) -le $MAX_LENGTH ]]; then
        echo "$track" "$artist"
        return
    fi

    if [[ $track_len -gt $HALF_LENGTH && $artist_len -gt $HALF_LENGTH ]]; then
        # Both too long - split evenly
        local track_max=$((MAX_LENGTH % 2 == 0 ? HALF_LENGTH - 2 : HALF_LENGTH - 1))
        track=$(truncate_text "$track" $((track_max + 1)))
        artist=$(truncate_text "$artist" $((HALF_LENGTH - 1)))
    elif [[ $track_len -gt $HALF_LENGTH ]]; then
        # Only track too long
        track=$(truncate_text "$track" $((MAX_LENGTH - artist_len)))
    elif [[ $artist_len -gt $HALF_LENGTH ]]; then
        # Only artist too long
        artist=$(truncate_text "$artist" $((MAX_LENGTH - track_len)))
    fi

    echo "$track" "$artist"
}

get_spotify_info_applescript() {
    local player_state track artist

    player_state=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)
    [[ $? -ne 0 ]] && return 1

    if [[ "$player_state" == "playing" || "$player_state" == "paused" ]]; then
        track=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
        artist=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)

        [[ $? -ne 0 ]] && return 1

        echo "$player_state" "$track" "$artist"
    else
        echo "$player_state" "" ""
    fi
}

set_sketchybar_item() {
    local state="$1"
    local track="$2"
    local artist="$3"

    case "$state" in
    "playing" | "Playing")
        sketchybar --set "$NAME" \
            icon.color="$GREEN" \
            label="${track}  ${artist}" \
            label.color="$GREEN" \
            background.color="$ITEM_COLOR" \
            label.drawing=yes \
            drawing=on
        ;;
    "paused" | "Paused")
        sketchybar --set "$NAME" \
            icon.color="$SUBTEXT0" \
            label="${track}  ${artist}" \
            label.color="$SUBTEXT0" \
            label.drawing=yes \
            background.color="$CRUST" \
            drawing=on
        ;;
    *)
        sketchybar --set "$NAME" \
            icon.color="$SUBTEXT0" \
            label="Spotify" \
            label.color="$SUBTEXT0" \
            label.drawing=yes \
            background.color="$ITEM_COLOR" \
            drawing=on
        ;;
    esac
}

update_track() {
    if ! is_spotify_running; then
        sketchybar --set "$NAME" drawing=off
        return
    fi

    local player_state track artist

    if [[ -n "$SPOTIFY_JSON" ]]; then
        # Parse event data
        player_state=$(echo "$SPOTIFY_JSON" | jq -r '.["Player State"]' 2>/dev/null)
        track=$(echo "$SPOTIFY_JSON" | jq -r '.Name' 2>/dev/null)
        artist=$(echo "$SPOTIFY_JSON" | jq -r '.Artist' 2>/dev/null)
    else
        # Use AppleScript
        local spotify_info
        spotify_info=$(get_spotify_info_applescript)

        if [[ $? -ne 0 ]]; then
            set_sketchybar_item "stopped" "" ""
            return
        fi

        read -r player_state track artist <<<"$spotify_info"
    fi

    # Apply truncation if we have track info
    if [[ -n "$track" && -n "$artist" ]]; then
        local truncated
        truncated=$(calculate_truncation "$track" "$artist")
        read -r track artist <<<"$truncated"
    fi

    set_sketchybar_item "$player_state" "$track" "$artist"
}

# Main logic
case "$SENDER" in
"mouse.clicked")
    if is_spotify_running; then
        osascript -e 'tell application "Spotify" to playpause' 2>/dev/null
    fi
    ;;
*)
    update_track
    ;;
esac
