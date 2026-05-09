{ config, pkgs, lib, ... }:
{
  networking.hostName = "nixos-garage";
  system.stateVersion = "25.11";

  networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.root.hashedPassword = "!";

  # Add dummy user to log in to the VM
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$6$EujOqFseDSt9/klh$nq7mr.rVhYGeVNwyfMoWmAH0dnVtN6e6zFoyTydFegrtw.5/QavGItK5TLmApdk90oJj13WINikyYrEUdlZil0";
  };
  
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  fileSystems."/run/secrets" = {
    device = "Asustor-Garage-Secrets";
    fsType = "virtiofs";
  };

  fileSystems."/var/lib/garage/data" = {
    device = "/dev/disk/by-uuid/b8c0ccb1-b1eb-48e3-9556-f1a4b8d042c4";
    fsType = "ext4";
  };

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
      rpc_secret_file = "/var/lib/garage/secrets/rpc-secret";

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
        admin_token_file = "/var/lib/garage/secrets/admin-token";
        metrics_token_file = "/var/lib/garage/secrets/metrics-token";
      };
    };
  };

  users.users.garage = {
    isSystemUser = true;
    group = "garage";
  };

  users.groups.garage = {};

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
        /run/secrets/garage-rpc-secret \
        /var/lib/garage/secrets/rpc-secret

      install -m 0600 -o garage -g garage \
        /run/secrets/garage-admin-token \
        /var/lib/garage/secrets/admin-token

      install -m 0600 -o garage -g garage \
        /run/secrets/garage-metrics-token \
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
    "d /var/lib/garage/meta 0700 garage garage -"
    "d /var/lib/garage/data 0700 garage garage -"

    "z /run/secrets/garage-rpc-secret 0600 garage garage - -"
    "z /run/secrets/garage-admin-token 0600 garage garage - -"
    "z /run/secrets/garage-metrics-token 0600 garage garage - -"
  ];

  imports = [
    ../../modules/tailscale.nix
  ];

  my.tailscale = {
    enable = true;
    enableFunnel = true;
    funnelPort = 3900;
  };
}
