{ config, pkgs, lib, ... }:

{
  networking.hostName = "microvm-ente";
  system.stateVersion = "25.11";

  microvm = {
    hypervisor = "qemu";
    vsock.cid = 5;
    vcpu = 1;
    mem = 1024;

    shares = [
      {
        proto = "virtiofs";
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
      {
        proto = "virtiofs";
        tag = "ente-secrets";
        source = "/run/ente-vm";
        mountPoint = "/run/secrets";
      }
      {
        proto = "virtiofs";
        tag = "ente-data";
        source = "/ente-data";
        mountPoint = "/data";
      }
    ];
    writableStoreOverlay = "/nix/.rw-store";

    interfaces = [{
      type = "tap";
      id = "microvm-ente";
      mac = "02:00:00:00:00:02";
    }];
  };

  systemd.network.enable = true;

  systemd.network.networks."10-eth0" = {
    matchConfig.Name = "e*";
    networkConfig = {
      Address = "192.168.1.51/24";
      Gateway = "192.168.1.1";
      DNS = [ "192.168.1.1" ];
    };
  };

  networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
  ];

  systemd.network.wait-online.enable = true;

  # Add dummy user to log in to the VM
  users.users.test = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "test";
  };
  services.openssh.enable = true;
  networking.firewall.enable = false;

  services.minio = {
    enable = true;
    # ente's config must match this region!
    region = "eu-central-2";
    rootCredentialsFile = "/run/secrets/minio-credentials";
    dataDir = [ "/data/minio" ];
  };

  systemd.services.minio.environment.MINIO_SERVER_URL = "http://localhost:9000";

  environment.systemPackages = [
    pkgs.minio-client
  ];

  services.postgresql = {
    enable = true;
    # Use persistent storage
    dataDir = "/data/postgres";
    #  PostgreSQL version
    package = pkgs.postgresql_15;
  };
}
