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
          modules-left = [ 
            "custom/launcher"
            "clock"
          ];

          modules-right = [
            "pulseaudio"
            "battery"
          ];
        }

        moduleSettings
        customModuleSettings
      ])
    ];
  };
}
