{ inputs, config, pkgs, lib, ... }:

{
  home.stateVersion = "25.11";

  imports = [
    ./desktop
    ./cli
    ./gui
    ./fonts
  ];
}
