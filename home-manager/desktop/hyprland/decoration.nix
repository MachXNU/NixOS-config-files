_: {

  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding       = 18;
      rounding_power = 4;

      active_opacity   = 1.0;
      inactive_opacity = 0.85;

      # https://wiki.hypr.land/Configuring/Variables/#blur
      blur = {
        enabled = true;
        xray = false;
        special = false;
        new_optimizations = true;
        size = 14;
        passes = 3;
        brightness = 1;
        noise= 0.01;
        contrast = 1;
        popups = true;
        popups_ignorealpha = 0.6;
        input_methods = true;
        input_methods_ignorealpha = 0.8;

        vibrancy = 0.1696;
      };

      shadow = {
        enabled = true;
        ignore_window = true;
        range = 30;
        offset = "0 2";
        render_power = 4;
        color = "$shadow";
      };

      dim_inactive = true;
      dim_strength = 0.025;
      dim_special = 0.07;
    };

    group = {
      "col.border_active" = "$tertiary";

      groupbar = {
        "col.active" = "$surface";
      };
    };
  };
}
