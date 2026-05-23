{pkgs, ...}: {
  home.packages = with pkgs; [
    virt-manager
    virt-viewer

    swtpm

    virtiofsd
    spice
  ];

  home.sessionVariables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
