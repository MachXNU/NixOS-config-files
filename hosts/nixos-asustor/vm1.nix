{ config, pkgs, ... }:

{
  microvm.vms.ddns = {
    autostart = false;

    config = { pkgs, ... }: {
      system.stateVersion = "25.11";

      networking.hostName = "ddns";
      networking.useDHCP = true;

      documentation.enable = false;

    };
  };
}
