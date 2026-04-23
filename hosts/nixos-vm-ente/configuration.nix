{ config, pkgs, lib, ... }:
{
  networking.hostName = "microvm-ente";
  system.stateVersion = "25.11";

  networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Add dummy user to log in to the VM

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  
  services.openssh.enable = false;

  services.garage = {
    enable = true;
    package = pkgs.garage_2;
    settings = {
      metadata_dir = "/var/lib/garage/meta";
      data_dir = "/var/lib/garage/data";
      db_engine = "sqlite";

      replication_factor = 1;

      rpc_bind_addr = "[::]:3901";
      rpc_public_addr = "127.0.0.1:3901";
      rpc_secret_file = "/run/secrets/garage-rpc-secret";

      s3_api = {
        s3_region = "garage";
        api_bind_addr = "[::]:3900";
      };

      s3_web = {
        bind_addr = "[::]:3902";
        root_domain = ".web.garage.localhost";
        index = "index.html";
      };

      k2v_api = {
        api_bind_addr = "[::]:3904";
      };

      admin = {
        api_bind_addr = "[::]:3903";
        admin_token_file = "/run/secrets/garage-admin-token";
        metrics_token_file = "/run/secrets/garage-metrics-token";
      };
    };
  };

  users.users.garage = {
    isSystemUser = true;
    group = "garage";
  };

  users.groups.garage = {};

  systemd.services.garage.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "garage";
    Group = "garage";
  };

  systemd.tmpfiles.rules = [
    "f /run/secrets/postgres-pguser-password 0640 root ente"
    "f /run/secrets/ente-garage-key 0640 root ente"
    "f /run/secrets/ente-garage-secret 0640 root ente"
    "f /run/secrets/api-key-encryption 0640 root ente"
    "f /run/secrets/api-key-hash 0640 root ente"
    "f /run/secrets/api-jwt-secret 0640 root ente"
    "f /run/secrets/garage-rpc-secret 0600 garage garage"
    "f /run/secrets/garage-admin-token 0600 garage garage"
    "f /run/secrets/garage-metrics-token 0600 garage garage"
    "d /var/lib/garage 0750 garage garage -"
    "d /var/lib/garage/meta 0750 garage garage -"
    "d /var/lib/garage/data 0750 garage garage -"
  ];

  services.postgresql = {
    enable = true;
    dataDir = "/data/postgres";
    package = pkgs.postgresql_15;
    authentication = pkgs.lib.mkOverride 10 ''
      local all postgres         peer map=postgres
      local all all              md5
      host  all all 127.0.0.1/32 md5
      host  all all ::1/128      md5
    '';
  };

  services.ente = {
    api = {
      enable = true;

      domain = "api.ente.prestuz.freeddns.org";

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
          enable = false;
          domains = {
            accounts = "accounts.ente.prestuz.freeddns.org";
            albums = "albums.ente.prestuz.freeddns.org";
            cast = "cast.ente.prestuz.freeddns.org";
            photos = "photos.ente.prestuz.freeddns.org";
          };
        };

        s3 = {
          use_path_style_urls = true;
          are_local_buckets = true;
          hot_storage = {
            primary = "b2-eu-cen";
          };
          b2-eu-cen = {
            endpoint = "https://s3.ente.prestuz.freeddns.org";
            region = "garage";
            bucket = "ente-bucket";
            key._secret = "/run/secrets/ente-garage-key";
            secret._secret = "/run/secrets/ente-garage-secret";
            are_local_buckets = true;
            use_path_style_urls = true;
          };
        };

        key = {
          encryption._secret = "/run/secrets/api-key-encryption";
          hash._secret = "/run/secrets/api-key-hash";
        };

        jwt.secret._secret = "/run/secrets/api-jwt-secret";
      };
    };

    # We must keep this part enabled, even though we don't use it
    # otherwise it doesn't build, or does not generate a config
    web = {
      enable = true;

      domains = {
        accounts = "accounts.ente.prestuz.freeddns.org";
        albums = "albums.ente.prestuz.freeddns.org";
        api = "api.ente.prestuz.freeddns.org";
        cast = "cast.ente.prestuz.freeddns.org";
        photos = "photos.ente.prestuz.freeddns.org";
      };
    };
  };

  services.nginx.enable = lib.mkForce false;
}
