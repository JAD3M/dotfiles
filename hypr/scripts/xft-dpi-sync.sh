#!/usr/bin/env bash
# Keep X11 (XWayland) Xft.dpi in sync with the focused monitor's Hyprland scale.
# Steam and other X11 apps derive their UI size from Xft.dpi at startup.

set -u

BASE_DPI=96
INTERVAL=2
last=""

while true; do
    scale=$(hyprctl monitors -j 2>/dev/null \
        | jq -r '(map(select(.focused)) | first // first // {}).scale // empty')
    if [ -n "$scale" ] && [ "$scale" != "$last" ]; then
        dpi=$(awk -v s="$scale" -v b="$BASE_DPI" 'BEGIN { printf "%d", b * s + 0.5 }')
        echo "Xft.dpi: $dpi" | xrdb -merge && last="$scale"
    fi
    sleep "$INTERVAL"
done
