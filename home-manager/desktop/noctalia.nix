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
        ui_scale = 1.1;
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
            "audio_visualizer"
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
        default = ./wallpapers/light/675027.png;
        directory_light = ./wallpapers/light;
        directory_dark = ./wallpapers/dark;
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

      shell = {
        avatar_path = ./.face;
        panel = {
          launcher_placement = "floating";
          open_near_click_control_center = true;
          open_near_click_session = true;
          transparency_mode = "soft";
        };

        screen_corners = {
          enabled = true;
          size = 13;
        };
      };

      theme = {
        mode = "auto";
        templates = {
          builtin_ids = [
            "gtk3"
            "gtk4"
            "hyprland"
            "qt"
          ];
        };
      };

      hooks = {
        theme_mode_changed = "noctalia msg wallpaper-random";
      };

      widget = {
        cat = {
          type = "noctalia/bongocat:cat";
        };

        clock = {
          vertical_format = "{:%H\\n%M}";
        };

        cpu = {
          show_value = false;
          stat = "cpu_temp";
        };

        launcher = {
          enabled = false;
        };

        network = {
          show_label = false;
        };

        ram = {
          show_value = false;
        };

        sysmon = {
          show_value = false;
        };

        workspaces = {
          capsule = true;
          capsule_opacity = 0.0;
          capsule_radius = 20;
          show_labels = false;
        };
      };

      desktop_widgets = {
        schema_version = 2;

        widget_order = [
          "desktop-widget-0000000000000001"
          "desktop-widget-0000000000000002"
          "desktop-widget-0000000000000003"
          "desktop-widget-0000000000000004"
          "desktop-widget-0000000000000005"
          "desktop-widget-0000000000000006"
          "desktop-widget-0000000000000007"
        ];

        grid = {
          cell_size = 8;
          major_interval = 4;
          visible = true;
        };

        widget = {
          "desktop-widget-0000000000000001" = {
            box_height = 152.0;
            box_width = 192.0;
            cx = 352.0;
            cy = 284.0;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 2560.0;
            rotation = 0.0;
            type = "clock";

            settings = {
              background = true;
              background_color = "surface";
              background_opacity = 0.6;
              background_radius = 5;
              color = "primary";
              format = "{:%H}";
              shadow = false;
            };
          };

          "desktop-widget-0000000000000002" = {
            box_height = 152.0;
            box_width = 192.0;
            cx = 496.0;
            cy = 472.0;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 2560.0;
            rotation = 0.0;
            type = "clock";

            settings = {
              background = true;
              background_color = "surface_variant";
              background_opacity = 0.7;
              background_radius = 5;
              color = "secondary";
              format = "{:%M}";
              shadow = false;
            };
          };

          "desktop-widget-0000000000000003" = {
            box_height = 32.0;
            box_width = 72.0;
            cx = 328.0;
            cy = 412.0;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 2560.0;
            rotation = 0.0;
            type = "clock";

            settings = {
              background_opacity = 0.8;
              background_padding = 4;
              background_radius = 0;
              color = "on_surface";
              format = "{:%Y}";
            };
          };

          "desktop-widget-0000000000000004" = {
            box_height = 8.0;
            box_width = 344.0;
            cx = 428.0;
            cy = 380.0;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 2560.0;
            rotation = 0.0;
            type = "label";

            settings = {
              background_padding = 0;
              background_radius = 0;
              opacity = 1.0;
              title = "";
            };
          };

          "desktop-widget-0000000000000005" = {
            box_height = 32.0;
            box_width = 112.0;
            cx = 532.0;
            cy = 280.0;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 2560.0;
            rotation = 0.0;
            type = "clock";

            settings = {
              background_padding = 5;
              background_radius = 0;
              center_text = false;
              color = "secondary";
              format = "{:%a,  %b}";
            };
          };

          "desktop-widget-0000000000000006" = {
            box_height = 48.0;
            box_width = 56.0;
            cx = 504.0;
            cy = 336.0;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 2560.0;
            rotation = 0.0;
            type = "clock";

            settings = {
              background_padding = 5;
              background_radius = 0;
              center_text = true;
              color = "tertiary";
              format = "{:%d}";
            };
          };

          "desktop-widget-0000000000000007" = {
            box_height = 40.0;
            box_width = 184.0;
            cx = 2412.0;
            cy = 1384.0;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 2560.0;
            rotation = 0.0;
            type = "label";

            settings = {
              background = false;
              color = "on_surface";
              font_family = "Chilanka";
              opacity = 0.75;
              shadow = false;
              title = "I use Nix btw";
            };
          };
        };
      };

    };
  };
}
