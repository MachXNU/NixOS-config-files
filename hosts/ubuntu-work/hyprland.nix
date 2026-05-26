{
  monitor = [
    ",1920x1080@60,0x0,1,bitdepth,10"
    "desc:BNQ BenQ EX2710Q C1R00852019,2560x1440@144,1920x-1080,1,bitdepth,10"
    "desc:Philips Consumer Electronics Company PHL 243V7 UHB1720022390,1920x1080@60,1920x0,1,bitdepth,8"
    "desc:Philips Consumer Electronics Company PHL 243V7 UHB1720023672,1920x1080@60,3840x0,1,bitdepth,8"
  ];

  env = [
    "LIBVA_DRIVER_NAME,nvidia"
    "GBM_BACKEND,nvidia-drm"
    "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    "WLR_NO_HARDWARE_CURSORS,1"
  ];
}
