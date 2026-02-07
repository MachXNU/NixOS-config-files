_: {

  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding       = 12;
      rounding_power = 2;

      active_opacity   = 1.0;
      inactive_opacity = 0.85;

      # https://wiki.hypr.land/Configuring/Variables/#blur
      blur = {
        enabled = true;
        size = 6;
        passes = 3;
        vibrancy = 0.1696;
      };

      shadow = {
        enabled = true;
        ignore_window = true;
        range = 30;
        offset = "0 2";
        render_power = 4;
        color = "rgb(000000)";
      };

      dim_inactive = true;
      dim_strength = 0.025;
      dim_special = 0.07;
    };

    layerrule = {
      name = "noctalia";
      "match:namespace" = "noctalia-background-.*";
      ignore_alpha = 0.3;
      blur_popups = true;
      blur = true;
    };

    group = {
      "col.border_active" = "$tertiary";

      groupbar = {
        "col.active" = "$surface";
      };
    };
  };
}
