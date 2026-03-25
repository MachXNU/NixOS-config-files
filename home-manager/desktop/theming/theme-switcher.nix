{ inputs, pkgs, ... }:
{
  home.file.".scripts/theme-switcher.sh" = {
    text = ''
      #!${pkgs.bash}/bin/bash

      THEME_DIR="${inputs.wallpapers.path}"
      CATPPUCCIN_DIR="${inputs.wallpapers-catppuccin}"

      #NOCTALIA_ABS=$(ps ax -o cmd | grep noctalia-shell | grep -v grep)
      NOCTALIA_ABS=/etc/profiles/per-user/$(whoami)/bin/noctalia-shell
      echo $NOCTALIA_ABS

      # List only non-hidden directories
      themes=($(find "$THEME_DIR" -mindepth 1 -maxdepth 1 -type d ! -iname ".*" -exec basename {} \; | sort))

      # Show menu
      selected=$(for theme in "''\${themes[@]}"; do printf '%s\0icon\x1f%s/.icons/%s.png\n' "$theme" "$THEME_DIR" "$theme"; done | rofi -dmenu -p " " -theme ~/.config/rofi/rofi-theme-selector-config.rasi -show-icons)
      
      # Capitalize theme name for Noctalia
      noctaliaColorScheme="''\${selected^}";

      # Apply selected theme if not empty
      if [[ -n "$selected" ]]; then
        if [ "$selected" = "catppuccin" ]; then
          WALLPAPER_DIR=$CATPPUCCIN_DIR
        else
          WALLPAPER_DIR=$THEME_DIR/$selected
        fi
        randomWallpaper=$(find $WALLPAPER_DIR -type f | shuf -n 1)
        $NOCTALIA_ABS ipc call colorScheme set $noctaliaColorScheme

        # set desktop wallpaper
        swww img "$randomWallpaper"

        # set Hyprlock wallpaper
        sed -i "/background {/,/}/ s|^\(\s*path=\).*|\1$randomWallpaper|" ~/.config/hypr/hyprlock.conf

        rm -f $HOME/.config/theme-wallpapers
        ln -sf $WALLPAPER_DIR $HOME/.config/theme-wallpapers

        echo $selected > $HOME/.config/theme-current
      else
        exit 1
      fi
    '';
    executable = true;
  };

  xdg.configFile."rofi/rofi-theme-selector-config.rasi".source = ./rofi-theme-selector-config.rasi;
}
