#!/usr/bin/env bash

THEME_DIR="$HOME/nixos-config/themes"
WALLPAPER_DIR="$HOME/wallpapers"
# APPLY_SCRIPT="$THEME_DIR/apply-theme.sh"

# List only non-hidden directories
themes=($(find "$THEME_DIR" -mindepth 1 -maxdepth 1 -type d ! -iname ".*" -exec basename {} \; | sort))

# Show menu
#selected=$(printf '%s\0icon\x1f%s/icon.png\n' "${themes[@]}" | rofi -dmenu -p " " -theme rofi-theme.rasi -show-icons)
selected=$(for theme in "${themes[@]}"; do printf '%s\0icon\x1f%s/icon.png\n' "$theme" "$theme"; done | rofi -dmenu -p " " -theme rofi-theme.rasi -show-icons -e "Hello")

noctaliaColorScheme="${selected^}";

# Apply selected theme if not empty
# [[ -n "$selected" ]] && "$APPLY_SCRIPT" "$selected" >/dev/null 2>&1
echo $noctaliaColorScheme

if [[ -n "$selected" ]]; then
  randomWallpaper=$(find $WALLPAPER_DIR/$selected -type f | shuf -n 1)
  noctalia-shell ipc call colorScheme set $noctaliaColorScheme
  noctalia-shell ipc call wallpaper set $randomWallpaper eDP-1
else
  exit 1
fi
