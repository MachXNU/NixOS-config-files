_: {

  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding       = 10;
      rounding_power = 4;

      active_opacity   = 1.0;
      inactive_opacity = 0.85;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "$shadow";
      };

      # https://wiki.hypr.land/Configuring/Variables/#blur
      blur = {
        enabled = true;
        xray = false;
        special = false;
        new_optimizations = true;
        size = 8;
        passes = 2;

        vibrancy = 0.1696;
      };
    };
  };
}
