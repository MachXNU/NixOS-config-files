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

  imports = lib.flatten [
    ./cli

    (
      if headless then
        [ ]
      else
        [
          (if isLinux then [ ./desktop ] else [ ])
          ./gui
          ./fonts
        ]
    )
  ];

  # Force override hyprland.conf by Home-Manager on rebuild
  # xdg.configFile."hypr/hyprland.conf".force = true;
}
