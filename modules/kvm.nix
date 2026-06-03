{ username, ... }:
{
  # NixOS settings

  # Remember to enable kernel modules and params with (for example):
  # boot.kernelModules = [ "kvm-amd" ];
  # boot.kernelParams = [ "amd_iommu=on" ];

  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      runAsRoot = false;
      swtpm.enable = true;
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;

  users.users.${username}.extraGroups = [ "libvirtd" ];

  imports = [
    ./home-manager/kvm.nix
  ];
}
