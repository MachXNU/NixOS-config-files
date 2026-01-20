{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 11;
    };
    settings = {
      shell = ".";

      italic_font = "auto";
      bold_font = "auto";
      bold_italic_font = "auto";

      # cursor = "#8fee96";

      background_opacity = "0.85";
      dynamic_background_opacity = "yes";

      confirm_os_window_close = 0;

      include = "./floraverse.conf";
    };
  };
}
