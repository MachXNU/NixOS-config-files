{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
  ];

  wayland.windowManager.hyprland.enable = true;
  
  imports = [
    ./binds.nix
  ];
}
