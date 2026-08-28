{ username, ... }:
{
  boot.kernelModules = [
    "kvm-amd"
    "i2c-dev"
  ];
  boot.kernelParams = [ "amd_iommu=on" ];

  imports = [
    ./nvidia.nix
    ../../modules/kvm.nix
    ../../modules/virtualbox.nix
    ../../modules/steam.nix
    ../../modules/tailscale.nix
  ];

  home-manager.users.${username} =
    { ... }:
    {
      programs.noctalia.settings.location.address = "Rotterdam, NL";
    };

  # For external monitor brightness control
  hardware.i2c.enable = true;
  users.groups.i2c = { };
  users.users.${username}.extraGroups = [ "i2c" ];

  my.tailscale = {
    enable = true;
    enableSSH = true;
  };

  services.usbmuxd.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="05ac", MODE="0666", TAG+="uaccess"
    KERNEL=="hidraw*", \
      SUBSYSTEM=="hidraw", \
      ATTRS{serial}=="*vial:f64c2b3c*", \
      MODE="0660", \
      GROUP="users", \
      TAG+="uaccess", \
      TAG+="udev-acl"
  '';
}
