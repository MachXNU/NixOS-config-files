{
  pkgs,
  lib,
  config,
  ...
}:

let
  moduleSettings = import ./modules.nix { }; 
  customModuleSettings = import ./custom-modules.nix { };
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      (lib.mkMerge [
        {
          layer = "top";
          position = "top";
          # height = 16;
          spacing = 8;
          margin-top = 8;
          margin-left = 8;
          margin-right = 8;
          mode = "dock";
          reload_style_on_change = true;

          modules-left = [ 
            "custom/appmenu"
            "clock"
            "hyprland/workspaces"
          ];

          modules-right = [
            "group/systemutils"
          ];
        }

        moduleSettings
        customModuleSettings
      ])
    ];
  };
  xdg.configFile."waybar/style.css".source = ./style.css;
}
