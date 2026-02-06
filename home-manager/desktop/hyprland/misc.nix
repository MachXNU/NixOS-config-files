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
    ];
  
    monitor = ",1920x1080x60,auto,1";

    source = "~/.config/hypr/matugen.conf";

    env = [
      "XCURSOR_THEME,Bibata-Modern-Ice"
      "XCURSOR_SIZE,24"
    ];
  };
}
