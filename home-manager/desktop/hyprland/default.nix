{ pkgs, hyprlandConfig, ... }:
let
  hostImport = if hyprlandConfig != null then "dofile(\"${toString hyprlandConfig}\")" else "";

  generatedLua = pkgs.replaceVars ./init.lua {
    dbusCmd = "${pkgs.dbus}/bin/dbus-update-activation-environment";
    waypaper = "${pkgs.waypaper}/bin/waypaper";
    inherit hostImport;
  };
in
{
  home.packages = with pkgs; [
    awww
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    configType = "lua";

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    extraConfig = builtins.readFile generatedLua;
  };

  imports = [
    ./screensharing.nix
  ];

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = [ "gtk" ];
      };

      Hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];

        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };
}
