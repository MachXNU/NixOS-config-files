{ config, pkgs, ...}: {
  imports = [
    ./hyprland
    ./hyprlock.nix
    ./noctalia.nix
    ./cursor.nix
    ./dconf.nix
  ];

  home.packages = [
    pkgs.adw-gtk3
    pkgs.obsidian
    pkgs.hyprshot
  ];
}
