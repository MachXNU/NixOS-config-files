{ config, lib, pkgs, ... }:

let
  cfg = config.my.garage;
in
{
  options.my.garage = {
    enable = lib.mkEnableOption "Garage";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.garage_2;
      description = "Garage package to use.";
    };

    region = lib.mkOption {
      type = lib.types.str;
      default = "garage";
      description = "Garage S3 region name.";
    };

    replicationFactor = lib.mkOption {
      type = lib.types.int;
      default = 1;
      description = "Garage replication factor.";
    };

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/garage/data";
      description = "Garage data directory.";
    };

    metadataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/garage/meta";
      description = "Garage metadata directory.";
    };

    rpcBindAddr = lib.mkOption {
      type = lib.types.str;
      default = "[::]:3901";
    };

    rpcPublicAddr = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1:3901";
    };

    s3ApiBindAddr = lib.mkOption {
      type = lib.types.str;
      default = "[::]:3900";
    };

    s3WebBindAddr = lib.mkOption {
      type = lib.types.str;
      default = "[::]:3902";
    };

    s3WebRootDomain = lib.mkOption {
      type = lib.types.str;
      default = ".web.garage.localhost";
    };

    k2vApiBindAddr = lib.mkOption {
      type = lib.types.str;
      default = "[::]:3904";
    };

    adminApiBindAddr = lib.mkOption {
      type = lib.types.str;
      default = "[::]:3903";
    };

    secretsMount = lib.mkOption {
      type = lib.types.str;
      default = "/run/secrets";
      description = "Directory containing Garage secret files.";
    };
  };

  config = lib.mkIf cfg.enable {

    users.users.garage = {
      isSystemUser = true;
      group = "garage";
    };

    users.groups.garage = {};

    services.garage = {
      enable = true;
      package = cfg.package;

      settings = {
        metadata_dir = cfg.metadataDir;
        data_dir = cfg.dataDir;

        db_engine = "sqlite";

        replication_factor = cfg.replicationFactor;

        rpc_bind_addr = cfg.rpcBindAddr;
        rpc_public_addr = cfg.rpcPublicAddr;
        rpc_secret_file = "/var/lib/garage/secrets/rpc-secret";

        s3_api = {
          s3_region = cfg.region;
          api_bind_addr = cfg.s3ApiBindAddr;
        };

        s3_web = {
          bind_addr = cfg.s3WebBindAddr;
          root_domain = cfg.s3WebRootDomain;
          index = "index.html";
        };

        k2v_api = {
          api_bind_addr = cfg.k2vApiBindAddr;
        };

        admin = {
          api_bind_addr = cfg.adminApiBindAddr;
          admin_token_file = "/var/lib/garage/secrets/admin-token";
          metrics_token_file = "/var/lib/garage/secrets/metrics-token";
        };
      };
    };

    systemd.services.garage-copy-secrets = {
      description = "Copy Garage secrets locally";

      before = [ "garage.service" ];
      wantedBy = [ "garage.service" ];

      after = [ "run-secrets.mount" ];
      requires = [ "run-secrets.mount" ];

      serviceConfig.Type = "oneshot";

      script = ''
        install -d -m 0700 -o garage -g garage /var/lib/garage/secrets

        install -m 0600 -o garage -g garage \
          ${cfg.secretsMount}/garage-rpc-secret \
          /var/lib/garage/secrets/rpc-secret

        install -m 0600 -o garage -g garage \
          ${cfg.secretsMount}/garage-admin-token \
          /var/lib/garage/secrets/admin-token

        install -m 0600 -o garage -g garage \
          ${cfg.secretsMount}/garage-metrics-token \
          /var/lib/garage/secrets/metrics-token
      '';
    };

    systemd.services.garage = {
      serviceConfig = {
        DynamicUser = lib.mkForce false;
        User = "garage";
        Group = "garage";
      };

      after = [ "run-secrets.mount" ];
      requires = [ "run-secrets.mount" ];
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/garage 0750 garage garage -"
      "d ${cfg.metadataDir} 0700 garage garage -"
      "d ${cfg.dataDir} 0700 garage garage -"

      "z ${cfg.secretsMount}/garage-rpc-secret 0600 garage garage - -"
      "z ${cfg.secretsMount}/garage-admin-token 0600 garage garage - -"
      "z ${cfg.secretsMount}/garage-metrics-token 0600 garage garage - -"
    ];
  };
}