{ inputs, pkgs, ... }:
{
  home.file.".scripts/theme-switcher.sh" = {
    text = ''
      #!${pkgs.bash}/bin/bash

      THEME_DIR="${inputs.wallpapers.path}"
      NOCTALIA_ABS=$(ps ax -o cmd | grep noctalia-shell | grep -v grep)
      echo $NOCTALIA_ABS

      # List only non-hidden directories
      themes=($(find "$THEME_DIR" -mindepth 1 -maxdepth 1 -type d ! -iname ".*" -exec basename {} \; | sort))

      # Show menu
      selected=$(for theme in "''\${themes[@]}"; do printf '%s\0icon\x1f%s/.icons/%s.png\n' "$theme" "$THEME_DIR" "$theme"; done | rofi -dmenu -p " " -theme ~/.config/rofi/rofi-theme-selector-config.rasi -show-icons)
      
      # Capitalize theme name for Noctalia
      noctaliaColorScheme="''\${selected^}";

      # Apply selected theme if not empty
      if [[ -n "$selected" ]]; then
        randomWallpaper=$(find $THEME_DIR/$selected -type f | shuf -n 1)
        $NOCTALIA_ABS ipc call colorScheme set $noctaliaColorScheme
        $NOCTALIA_ABS ipc call wallpaper set "$randomWallpaper" eDP-1
      else
        exit 1
      fi
    '';
    executable = true;
  };

  xdg.configFile."rofi/rofi-theme-selector-config.rasi".source = ./rofi-theme-selector-config.rasi;
}
