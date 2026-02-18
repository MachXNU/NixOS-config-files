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

  # Force override hyprland.conf by Home-Manager on rebuild
  # xdg.configFile."hypr/hyprland.conf".force = true;
}
