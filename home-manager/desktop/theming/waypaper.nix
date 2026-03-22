{ config, pkgs, lib, ... }:

{
  home.file.".config/waypaper/config.ini".text = lib.generators.toINI {} {
    Settings = {
      language = "en";
      show_path_in_tooltip = true;
      fill = "fill";
      sort = "name";
      color = "#ffffff";
      subfolders = true;
      all_subfolders = true;
      show_hidden = false;
      show_gifs_only = false;
      zen_mode = true;
      post_command = "kill -9 $(pgrep waypaper)";
      number_of_columns = 5;
      swww_transition_type = "any";
      swww_transition_step = 63;
      swww_transition_angle = 0;
      swww_transition_duration = 2;
      swww_transition_fps = 60;
      mpvpaper_sound = false;
      mpvpaper_options = "";
      use_xdg_state = true;
      #stylesheet = "/home/jb/.config/waypaper/style.css";
      #keybindings = "$HOME/.config/waypaper/keybindings.ini";
    };
  };
}
