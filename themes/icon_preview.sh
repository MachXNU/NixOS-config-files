#!/usr/bin/env bash

# $1 is the input (folder name)
# $2 is the output file path
# $3 is the requested size

# Define the path to the folder containing the icons
ICON_DIR="$HOME/nixos-config/themes"

# Path to the icon file for the selected folder
ICON_PATH="$ICON_DIR/$1/icon.png"

# Check if the icon exists
if [[ -f "$ICON_PATH" ]]; then
  # If the icon exists, copy it to the output path
  cp "$ICON_PATH" "$2"
else
  # If no icon found, use a default icon (optional)
  cp "$ICON_DIR/default_icon.png" "$2"
fi

# Optionally, resize if requested
magick "$2" -resize "$3"x"$3" "$2"  # Using ImageMagick to resize
