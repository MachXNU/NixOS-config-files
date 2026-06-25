{ pkgs, hyprlandConfig, ... }:
let
  hostImport = if hyprlandConfig != null then "dofile(\"${toString hyprlandConfig}\")" else "";

  generatedLua = pkgs.replaceVars ./lua/init.lua {
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

    systemd.enable = true;

    extraConfig = builtins.readFile generatedLua;
  };

  imports = [
    ./screensharing.nix
  ];
}
