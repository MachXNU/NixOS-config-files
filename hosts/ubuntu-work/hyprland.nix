{
  monitor = [
    ",1920x1080@60,0x0,1,bitdepth,10"
    "desc:BNQ BenQ EX2710Q C1R00852019,2560x1440@144,1920x-1080,1,bitdepth,10"
  ];

  env = [
    "LIBVA_DRIVER_NAME,nvidia"
    "GBM_BACKEND,nvidia-drm"
    "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    "WLR_NO_HARDWARE_CURSORS,1"
  ];
}
