{ config, lib, pkgs, ... }: {

  # fileSystems."/" = {
  #   device = "/dev/disk/by-label/nixos";
  #   autoResize = true;
  #   fsType = "ext4";
  # };

  # boot.kernelParams = ["console=ttyS0"];

  system.build.qcow2 = import "${pkgs.path}/nixos/lib/make-disk-image.nix" {
    inherit lib config pkgs;
    diskSize = 10240;
    format = "qcow2";
    partitionTableType = "hybrid";
  };
}