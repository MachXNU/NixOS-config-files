{ config, lib, pkgs, ... }:

{
  options.my.networking = {
    useSystemdNetwork = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use Systemd Network instead of Network Manager (only recommended if running MicroVMs for now)";
    };
  };

  config = {
    networking.networkmanager.enable = !config.my.networking.useSystemdNetwork;

    networking.useNetworkd = config.my.networking.useSystemdNetwork;
    systemd.network.enable = config.my.networking.useSystemdNetwork;

    # Define bridge device
    systemd.network.netdevs."br0" = {
      netdevConfig = {
        Kind = "bridge";
        Name = "br0";
      };
    };

    # Physical NIC joins bridge
    systemd.network.networks."10-enp2s0" = {
      matchConfig.Name = "enp2s0";
      networkConfig.Bridge = "br0";
    };

    # Tap interface joins bridge
    systemd.network.networks."20-microvm" = {
      matchConfig.Name = "microvm-ddns";
      networkConfig.Bridge = "br0";
    };

   # Bridge gets the LAN IP (DHCP example)
    systemd.network.networks."30-br0" = {
      matchConfig.Name = "br0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
    };
  };
}
