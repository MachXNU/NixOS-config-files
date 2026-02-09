{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qemu
    qemu_kvm
    libvirt
    virt-manager
  ];

  home.sessionVariables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
}
