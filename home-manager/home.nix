{
  pkgs,
  lib,
  headless,
  username,
  homeDirectory,
  isLinux,
  ...
}:
let
  light_theme = "${pkgs.base16-schemes}/share/themes/penumbra-light-contrast-plus-plus.yaml";
  dark_theme = "${pkgs.base16-schemes}/share/themes/phd.yaml";
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  imports = [
    ../modules/theming.nix
    ./cli
  ]
  ++ lib.optionals (!headless) [
    ./gui
    ./fonts
  ]
  ++ lib.optionals (!headless && isLinux) [
    ./desktop
  ];

  # Force override hyprland.conf by Home-Manager on rebuild
  # xdg.configFile."hypr/hyprland.conf".force = true;
}
