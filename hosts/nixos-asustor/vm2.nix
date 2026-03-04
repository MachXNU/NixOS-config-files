{ config, pkgs, ... }:

{
  microvm.vms.ddns = {
    autostart = true;

    config = { pkgs, ... }: {
      # It is highly recommended to share the host's nix-store
      # with the VMs to prevent building huge images.
      microvm.shares = [{
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
        tag = "ro-store";
        proto = "virtiofs";
      }];

      networking.hostName = "ddns";
      networking.useDHCP = true;

      documentation.enable = false;

      services.getty.autologinUser = "root";
    };
  };
}
