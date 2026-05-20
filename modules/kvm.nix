{username, ...}: {
  # NixOS settings

  # Remember to enable kernel modules and params with (for example):
  # boot.kernelModules = [ "kvm-amd" ];
  # boot.kernelParams = [ "amd_iommu=on" ];

  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      runAsRoot = false;
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;

  users.users.${username}.extraGroups = ["libvirtd"];

  # Home-Manager settings
  home-manager.users.${username} = {pkgs, ...}: {
    home.packages = with pkgs; [
      qemu
      qemu_kvm
      libvirt
      virt-manager
    ];

    home.sessionVariables = {
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };
  };
}
