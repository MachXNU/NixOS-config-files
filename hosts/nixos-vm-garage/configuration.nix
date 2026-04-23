{ config, pkgs, lib, ... }:
{
  networking.hostName = "nixos-garage";
  system.stateVersion = "25.11";

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.root.hashedPassword = "!";

  # Add dummy user to log in to the VM
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  
  services.openssh.enable = false;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

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
}
