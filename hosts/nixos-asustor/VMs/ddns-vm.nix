{ config, pkgs, lib, ... }:

{
  networking.hostName = "microvm-ddns";
  system.stateVersion = "25.11";

  microvm = {
    hypervisor = "qemu";
    vsock.cid = 4;
    vcpu = 1;
    mem = 512;

    shares = [
      {
        proto = "virtiofs";
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
      {
        proto = "virtiofs";
        tag = "ddns-updater-secrets";
        source = "/run/ddns-vm";
        mountPoint = "/etc/ddns-updater";
      }
    ];
    writableStoreOverlay = "/nix/.rw-store";

    interfaces = [{
      type = "tap";
      id = "microvm-ddns";
      mac = "02:00:00:00:00:01";
    }];
  };

  systemd.network.enable = true;

  systemd.network.networks."10-eth0" = {
    matchConfig.Name = "e*";
    networkConfig = {
      Address = "192.168.1.50/24";
      Gateway = "192.168.1.1";
      DNS = [ "192.168.1.1" ];
    };
  };

  networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
  ];

  systemd.network.wait-online.enable = true;

  users.users.ddns = {
    isSystemUser = true;
    group = "ddns";
  };

  users.groups.ddns = {};

  systemd.services.ddns-updater.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "ddns";
    Group = "ddns";
  };

  systemd.tmpfiles.rules = [
    "f /etc/ddns-updater/config.json 0640 root ddns"
  ];

  services.ddns-updater = {
    enable = true;
    environment = {
      SERVER_ENABLED="no";
      CONFIG_FILEPATH = "/etc/ddns-updater/config.json";
      PERIOD = "5m";
    };
  };
}
