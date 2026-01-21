{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
  };  
  imports = [
    ./binds.nix
    ./decoration.nix
    ./general.nix
  ];
}
