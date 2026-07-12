{ lib, username, ... }:
{
  imports = [
    ./apple-silicon-support
    ../../modules/steam.nix
    ../../modules/tailscale.nix
  ];

  # Enable basic nixos-apple-silicon support.
  hardware.asahi.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  home-manager.users.${username} =
    { ... }:
    {
      programs.noctalia-shell.settings.location.name = "Rotterdam, NL";
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
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", \
      ATTRS{serial}=="*vial:f64c2b3c*", \
      ATTRS{idVendor}=="feed", \
      ATTRS{idProduct}=="0000", \
      MODE="0660", \
      TAG+="uaccess"
  '';
}
