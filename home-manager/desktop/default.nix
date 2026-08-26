{
  pkgs,
  ...
}:
{
  imports = [
    ./hypridle.nix
    ./hyprland
    ./hyprlock.nix
    ./noctalia.nix
    ./cursor.nix
    ./dconf.nix
    ./waypaper.nix
    ./mangohud.nix
    ./gpu-screen-recorder.nix
  ];

  home.packages = with pkgs; [
    adw-gtk3
    brightnessctl
    hyprshot
    waypaper
  ];

  xdg.configFile."gtk-3.0/gtk.css".force = true;
  xdg.configFile."gtk-4.0/gtk.css".force = true;
}
