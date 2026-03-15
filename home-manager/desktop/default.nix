{ config, pkgs, ...}: {
  imports = [
    ./hypridle.nix
    ./hyprland
    ./hyprlock.nix
    ./noctalia.nix
    ./cursor.nix
    ./dconf.nix
    ./theming
  ];

  home.packages = with pkgs; [
    adw-gtk3
    brightnessctl
    obsidian
    hyprshot
  ];
}
