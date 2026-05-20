{
  hostName,
  hyprlockLayout ? null,
  ...
}: let
  layout =
    if hyprlockLayout != null
    then hyprlockLayout
    else import ./desktop/hyprlock-default-layout.nix;
in {
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
        (
          {
            monitor = "";
            text = "cmd[update:1000] echo \"<span>$(date +\"%I\")</span>\"";
            color = "rgb(236, 239, 244)";
            font_size = 200;
            font_family = "Stretch Pro";
            # position = "-80, 190";
          }
          // layout.hour
        )

        # Time Minute
        (
          {
            monitor = "";
            text = "cmd[update:1000] echo \"<span>$(date +\"%M\")</span>\"";
            color = "rgba(113, 130, 155, 0.9)";
            font_size = 200;
            font_family = "Stretch Pro";
          }
          // layout.minute
        )

        # Day-Month-Date
        (
          {
            monitor = "";
            text = "cmd[update:1000] echo -e \"$(date +\"%d %B, %a.\")\"";
            # color = "rgba(255, 255, 255, 100)";
            color = "rgba(59, 66, 82, 0.95)";
            font_size = 28;
            font_family = "DejaVu Sans";
          }
          // layout.date
        )

        # User
        (
          {
            monitor = "";
            # text = "    $USER";
            text = " Hi,  $USER";
            color = "rgba(236, 239, 244, 0.8)";
            font_family = "SF Pro Display Bold";
          }
          // layout.user
        )
      ];

      # Profile-Photo
      image =
        {
          monitor = "";
          path = toString ./.face;
          border_size = 2;
          border_color = "rgba(216, 222, 233, 0.80)";
          rounding = -1;
          rotate = 0;
          reload_time = -1;
          reload_cmd = "";
        }
        // layout.image;

      input-field =
        {
          monitor = "";
          outline_thickness = 2;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          check_color = "$primary";
          fail_color = "$on_error";
          font_family = "Deja Vu Sans";
          placeholder_text = "<span foreground=\"##ffffff99\">Enter password</span>";
          hide_input = false;
        }
        // layout.input;

      background = {
        monitor = "";
        path = toString ../../wallpapers/Hollow-Knight/Hornet-corner-black.png;
        blur_passes = 3;
        contrast = 0.8916;
        brightness = 0.5;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
    };
  };
}
