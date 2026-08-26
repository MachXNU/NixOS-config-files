{
  config,
  lib,
  hyprlockLayout ? null,
  ...
}:
let
  layout =
    if hyprlockLayout != null then hyprlockLayout else import ./desktop/hyprlock-default-layout.nix;
in
{
  programs.hyprlock = {
    enable = true;

    importantPrefixes = [
      "$"
      "source"
    ];

    settings = {
      source = "~/.config/hypr/noctalia/noctalia-colors.conf";

      general = { };

      label = [
        # Time Hour
        (
          {
            monitor = "";
            text = "cmd[update:1000] echo \"<span>$(date +\"%I\")</span>\"";
            color = "rgb(${config.lib.stylix.colors.base00})";
            #font_size = 200;
            font_family = "Stretch Pro";
          }
          // layout.hour
        )

        # Time Minute
        (
          {
            monitor = "";
            text = "cmd[update:1000] echo \"<span>$(date +\"%M\")</span>\"";
            color = "rgb(${config.lib.stylix.colors.base03})";
            #font_size = 200;
            font_family = "Stretch Pro";
          }
          // layout.minute
        )

        # Day-Month-Date
        (
          {
            monitor = "";
            text = "cmd[update:1000] echo \"<span>$(date +\"%d %B, %a.\")</span>\"";
            color = "rgb(${config.lib.stylix.colors.base05})";
            #font_size = 28;
            font_family = "DejaVu Sans";
          }
          // layout.date
        )

        # User
        (
          {
            monitor = "";
            text = " Hi,  $USER";
            color = "rgb(${config.lib.stylix.colors.base00})";
            font_family = "SF Pro Display Bold";
          }
          // layout.user
        )
      ];

      # Profile-Photo
      image = {
        monitor = "";
        path = toString ./.face;
        border_size = 2;
        border_color = lib.mkForce "rgb(${config.lib.stylix.colors.base02})";
        rounding = -1;
        rotate = 0;
        reload_time = -1;
        reload_cmd = "";
      }
      // layout.image;

      input-field = {
        monitor = "";
        outline_thickness = 2;
        inner_color = lib.mkForce "rgb(${config.lib.stylix.colors.base06})";
        font_color = lib.mkForce "rgb(${config.lib.stylix.colors.base02})";
        fade_on_empty = false;
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
        color = lib.mkForce "rgb(${config.lib.stylix.colors.base07})";
      };
      auth = {
        pam.enabled = true;
      }
      // layout.auth;
    };
  };

  xdg.configFile."hypr/hyprlock.conf".force = true;
}
