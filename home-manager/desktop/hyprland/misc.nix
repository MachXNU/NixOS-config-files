_: {

  wayland.windowManager.hyprland.settings = {
    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo   = true;
    };

    exec-once = [
      # "killall -q swww;  sleep .5 && swww-daemon"
      # "killall -q waybar;sleep .5 && waybar"
      "noctalia-shell"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "waypaper --restore --state-file $HOME/.config/waypaper/status"
    ];
  
    source = "~/.config/hypr/noctalia/noctalia-colors.conf";

    env = [
      "XDG_SESSION_TYPE,wayland"
      "XCURSOR_THEME,Bibata-Modern-Ice"
      "XCURSOR_SIZE,24"
    ];
  };

  xdg.configFile."matugen/hyprland-colors.css".text = ''
    $image = {{image}}
    <* for name, value in colors *>
    ''${{name}} = rgba({{value.default.hex_stripped}}ff)
    <* endfor *>

    general {
        col.active_border = $primary
        col.inactive_border = $surface
    }

    group {
        col.border_active = $secondary
        col.border_inactive = $surface
        col.border_locked_active = $error
        col.border_locked_inactive = $surface

        groupbar {
            col.active = $secondary
            col.inactive = $surface
            col.locked_active = $error
            col.locked_inactive = $surface
        }
    }
  '';
}
