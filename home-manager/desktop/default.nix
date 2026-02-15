{ config, ...}: {
  imports = [
    ./hyprland
    ./noctalia.nix
    ./cursor.nix
    ./dconf.nix
  ];
}
