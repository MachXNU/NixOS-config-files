_:
{
  # NixOS config
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = true;

    open = false; # aka proprietary drivers 

    nvidiaSettings = true;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;

      amdgpuBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  boot.initrd.kernelModules = [ "i915" ];

  # Home-manager config (Wayland)
  home-manager.users.jb = { ... }: {
    wayland.windowManager.hyprland.settings = {
      monitor = ",2880x1800@90,auto,1.5";

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];
    };
  };
}
