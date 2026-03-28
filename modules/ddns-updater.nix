{ config, lib, ... }:

{
  users.users.ddns = {
    isSystemUser = true;
    group = "ddns";
  };

  users.groups.ddns = {};

  systemd.services.ddns-updater.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "ddns";
    Group = "ddns";
    Environment = [
      "GODEBUG=netdns=go"
    ];
  };

  services.ddns-updater = {
    enable = true;
    environment = {
      SERVER_ENABLED="yes";
      CONFIG_FILEPATH = config.age.secrets.ddns-updater-config-json.path;
      PERIOD = "5m";
      LOG_LEVEL = "debug";
    };
  };

  networking.firewall.allowedUDPPorts = [ 53 ];
}
