{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = ",1920x1080@60,auto,1";
    env = [
      "XDG_SESSION_TYPE,wayland"
      "LIBVA_DRIVER_NAME,nvidia"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "WLR_NO_HARDWARE_CURSORS,1"
    ];
  };

  programs.noctalia-shell.settings.location.name = "Paris, France";
}
