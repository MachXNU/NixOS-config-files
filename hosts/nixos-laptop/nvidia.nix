_:
{
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
}
