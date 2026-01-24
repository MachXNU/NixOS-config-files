_: {

  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 4;
      gaps_out = 8;

      border_size = 2;

      "col.active_border" = "$primary"; 
      # was "rgba(33ccffee) rgba(00ff99ee) 45deg";
      
      "col.inactive_border" = "$on_secondary_fixed";
      # was "rgba(595959aa)";

      resize_on_border = false;

      allow_tearing = false;

      layout = "master";
    };
  };
}
