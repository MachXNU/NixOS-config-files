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

  systemd.tmpfiles.rules = [
    "f /run/secrets/postgres-pguser-password 0640 root ente"
    "f /run/secrets/api-s3-b2-eu-cen-key 0640 root ente"
    "f /run/secrets/api-s3-b2-eu-cen-secret 0640 root ente"
    "f /run/secrets/api-key-encryption 0640 root ente"
    "f /run/secrets/api-key-hash 0640 root ente"
    "f /run/secrets/api-jwt-secret 0640 root ente"
  ];

  services.postgresql = {
    enable = true;
    # Use persistent storage
    dataDir = "/data/postgres";
    #  PostgreSQL version
    package = pkgs.postgresql_15;
    authentication = pkgs.lib.mkOverride 10 ''
      local all postgres         peer map=postgres
      local all all              md5
      host  all all 127.0.0.1/32 md5
      host  all all ::1/128      md5
    '';
  };

  services.ente.api = {
    enable = true;

    settings = {
      db = {
        host = "127.0.0.1";
        port = 5432;
        name = "ente_db";
        user = "pguser";
        password._secret = "/run/secrets/postgres-pguser-password";
        sslmode = "disable";
      };

      web = {
        enable = true;
        domains = {
          accounts = "accounts.ente.prestuz.freeddns.org";
          albums = "albums.ente.prestuz.freeddns.org";
          cast = "cast.ente.prestuz.freeddns.org";
          photos = "photos.ente.prestuz.freeddns.org";
        };
      };

      s3 = {
        use_path_style_urls = true;
        b2-eu-cen = {
          endpoint = "http://localhost:9000";
          region = "eu-central-2";
          bucket = "1580559962386438";
          key._secret = "/run/secrets/api-s3-b2-eu-cen-key";
          secret._secret = "/run/secrets/api-s3-b2-eu-cen-secret";
        };
      };

      webauthn = {
        rpid = "localhost";
        rporigins = [ "http://localhost:3001" ];
      };

      key = {
        encryption._secret = "/run/secrets/api-key-encryption";
        hash._secret = "/run/secrets/api-key-hash";
      };

      jwt.secret._secret = "/run/secrets/api-jwt-secret";
    };
  };
}
