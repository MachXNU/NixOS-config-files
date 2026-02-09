{ ... }:
{
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "amd_iommu=on" ];

  virtualisation.spiceUSBRedirection.enable = true;

  imports = [
    ./nvidia.nix
    ../common/KVM/default.nix
  ];
}
