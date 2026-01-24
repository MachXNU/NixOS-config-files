_: {

  wayland.windowManager.hyprland.settings = {
    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo   = true;
    };

    exec-once = [
      "waybar"
    ];
  
    monitor = ",1920x1080x60,auto,1";

    source = "~/.config/hypr/matugen.conf";

  };
}
