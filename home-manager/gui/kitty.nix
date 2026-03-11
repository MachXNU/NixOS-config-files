{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 11;
    };
    settings = {
      include = "themes/noctalia.conf";
      shell = ".";

      italic_font = "auto";
      bold_font = "auto";
      bold_italic_font = "auto";

      remember_window_size = "no";
      cursor_blink_interval = "0.5";

      cursor_trail = "1";
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = "6";

      wheel_scroll_min_lines = "1";
      enable_audio_bell = "no";

      window_padding_width = "10 15";
      hide_window_decorations = "yes";
      background_opacity = 0.9;
      dynamic_background_opacity = "yes";

      # cursor = "#8fee96";

      confirm_os_window_close = 0;
      linux_display_server = "wayland";

      shell_integration = "enabled";
    };
  };

  home.packages = [
    pkgs.kitty.terminfo
  ];
}
