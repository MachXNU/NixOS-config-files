{ config, pkgs, ...}: {
  programs.hyprlock = {
    enable = true;

    importantPrefixes = [
      "$"
      "source"
    ];

    settings = {
      source = "~/.config/hypr/noctalia/noctalia-colors.conf";

      general = {};
      
      label = [
        # Time Hour
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date +\"%I\")</span>\"";
          # color = "rgba(255, 255, 255, 1)";
          color = "$tertiary_fixed";
          font_size = 200;
          font_family = "Stretch Pro";
          # position = "-80, 190";
          position = "-8%, 18%";
          halign = "center";
          valign = "center";
        }

        # Time Minute
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date +\"%M\")</span>\"";
          color = "$tertiary_fixed_dim";
          font_size = 200;
          font_family = "Stretch Pro";
          position = "0, 7%";
          halign = "center";
          valign = "center";
        }

        # Day-Month-Date
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%d %B, %a.\")\"";
          # color = "rgba(255, 255, 255, 100)";
          color = "$tertiary_fixed";
          font_size = 28;
          font_family = "Suisse Int'l Mono";
          position = "2%, 1%";
          halign = "center";
          valign = "center";
        }

        # User
        {
          monitor = "";
          # text = "    $USER";
          text = " Hi,  $USER";
          color = "rgba(216, 222, 233, 0.80)";
          font_size = 30;
          font_family = "SF Pro Display Bold";
          position = "0, -35%";
          halign = "center";
          valign = "center";
        }
      ];

      # Profie-Photo
      image = {
          monitor = "";
          path = toString ./.face;
          border_size = 2;
          border_color = "rgba(216, 222, 233, 0.80)";
          size = 150;
          rounding = -1;
          rotate = 0;
          reload_time = -1;
          reload_cmd = "";
          position = "0, -28%";
          halign = "center";
          valign = "center";
      };

      input-field = {
        monitor ="";
        size = "380, 75";
        outline_thickness = 2;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(255, 255, 255, 0.1)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        font_family = "Deja Vu Sans";
        placeholder_text = "<span foreground=\"##ffffff99\">Enter password</span>";
        hide_input = false;
        position = "0, -40%";
        halign = "center";
        valign = "center";
      };

      background = {
          monitor = "";
          path = toString ./Wallpapers/blue-abstract-5120x5120.jpg;
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
      };
    };
  };

}
