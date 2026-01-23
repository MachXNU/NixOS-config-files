{
  pkgs,
  lib,
  config,
  ...
}:

let
  moduleSettings = import ./modules.nix { }; 
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
          ];
        }

        moduleSettings
      ])
    ];
  };
}
