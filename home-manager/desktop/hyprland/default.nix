{ pkgs, ... }:

{
  home.packages = with pkgs; [
   awww 
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
  };  

  imports = [
    ./binds.nix
    ./decoration.nix
    ./general.nix
    ./animations.nix
    ./misc.nix
    ./inputs.nix
    ./screensharing.nix
  ];
}
