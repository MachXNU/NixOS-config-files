{ config, pkgs, ...}: {
  imports = [
    ./rofi.nix
    ./theme-switcher.nix
  ];
}
