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
    AmbientCapabilities = "";
    CapabilityBoundingSet = "";
    DevicePolicy = "closed"; # fails at stdin if "strict"
    LockPersonality = true;
    MemoryDenyWriteExecute = true;
    NoNewPrivileges = true;
    ProcSubset = "pid";
    ProtectClock = true;
    ProtectControlGroups = true;
    ProtectHome = true;
    ProtectHostname = true;
    ProtectKernelTunables = true;
    ProtectKernelModules = true;
    ProtectKernelLogs = true;
    ProtectProc = "noaccess";
    ProtectSystem = "strict";
    PrivateDevices = true;
    PrivateTmp = true;
    PrivateUsers = true;
    RemoveIPC = true;
    RestrictAddressFamilies = [
      "AF_INET"
      "AF_INET6"
      "AF_UNIX"
    ];
    RestrictNamespaces = true;
    RestrictRealtime = true;
    RestrictSUIDSGID = true;
    SystemCallArchitectures = "native";
    SystemCallFilter = [
      "@system-service"
      "~@privileged"
      "~@resources"
    ];
    Umask = "0077";
  };

  services.ddns-updater = {
    enable = true;
    environment = {
      SERVER_ENABLED="no";
      CONFIG_FILEPATH = config.age.secrets.ddns-updater-config-json.path;
      PERIOD = "5m";
      LOG_LEVEL = "info";
    };
  };

  networking.firewall.allowedUDPPorts = [ 53 ];
}
