{ config, pkgs, ...}: {
  imports = [
    ./hyprland
    ./noctalia.nix
    ./cursor.nix
    ./dconf.nix
  ];

  home.packages = [
    pkgs.adw-gtk3
  ];
}
