{ inputs, config, pkgs, lib, headless, ... }:

{
  home.stateVersion = "25.11";

  imports = lib.flatten [
    ./cli

    (if headless then [] else [
      ./desktop
      ./gui
      ./fonts
    ])
  ];
}
