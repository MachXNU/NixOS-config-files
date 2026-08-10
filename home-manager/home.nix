{
  lib,
  headless,
  username,
  homeDirectory,
  isLinux,
  ...
}:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  imports = [
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
