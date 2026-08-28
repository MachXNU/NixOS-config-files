{
  inputs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      accessibility = {
        ui_scale = 1.3;
      };

      bar = {
        order = [ "default" ];

        default = {
          capsule_radius = 5;
          concave_edge_corners = false;
          margin_edge = 5;
          margin_ends = 4;
          padding = 10;
          position = "left";
          scale = 0.95;
          thickness = 30;
          widget_spacing = 14;

          start = [
            "control-center"
            "network"
            "bluetooth"
            "cat"
            "session"
          ];
          center = [ "workspaces" ];
          end = [
            "group:g1"
            "battery"
            "clock"
          ];

          capsule_group = [
            {
              accordion = false;
              accordion_direction = "end";
              enabled = true;
              fill = "surface_variant";
              id = "g1";
              members = [
                "sysmon"
                "cpu"
                "ram"
              ];
              opacity = 1.0;
              padding = 6.0;
            }
          ];
        };
      };

      control_center = {
        show_shortcut_labels = false;

        shortcuts = [
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "caffeine"; }
          { type = "nightlight"; }
          { type = "power_profile"; }
          { type = "dark_mode"; }
        ];
      };

      lockscreen = {
        enabled = false;
      };

      nightlight = {
        enabled = true;
      };

      wallpaper = {
        enabled = true;
        directory_light = ../desktop/wallpapers/light;
        directory_dark = ../desktop/wallpapers/dark;
      };
      plugins = {
        enabled = [
          "noctalia/screen_recorder"
          "noctalia/kaomoji"
          "noctalia/mpvpaper"
          "oldirtty/color_picker"
          "noctalia/bongocat"
        ];
      };
    };
  };
}
