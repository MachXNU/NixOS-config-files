{ ... }:
{
  imports = [
    ../common/KVM/home-manager-config.nix
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = ",2560x1440@144,auto,1,bitdepth,10";
    env = [
      "XDG_SESSION_TYPE,wayland"
      "LIBVA_DRIVER_NAME,nvidia"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "WLR_NO_HARDWARE_CURSORS,1"
    ];
  };

  programs.noctalia-shell.settings.location.name = "Rennes, France";
}
