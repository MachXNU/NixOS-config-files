{ inputs, pkgs, ... }:

{
  programs.ranger = {
    enable = true;

    plugins = [
      {
        name = "ranger_devicons";
        src = inputs.ranger-devicons;
      }
    ];

    extraConfig = ''
      default_linemode devicons

      set preview_files true
      set preview_images_method kitty

      set draw_borders both 
    '';
  };

  home.sessionVariables = {
    RANGER_DEVICONS_SEPARATOR = " ";
    DEVICONS_LANG = "en";
  };
}
