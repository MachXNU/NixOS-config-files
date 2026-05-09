{ config, lib, pkgs, ... }:

{
  options.my.tailscale = {
    enable = lib.mkEnableOption "Tailscale";

    authKeyFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to Tailscale auth key file.";
    };

    enableSSH = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Tailscale SSH (--ssh).";
    };

    enableFunnel = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Tailscale Funnel.";
    };

    funnelPort = lib.mkOption {
      type = lib.types.port;
      default = 3000;
      description = "Local port exposed through Tailscale Funnel.";
    };
  };

  config = {
    services.tailscale = {
      enable = true;

      authKeyFile =
        lib.mkIf (config.my.tailscale.authKeyFile != null)
          config.my.tailscale.authKeyFile;

      extraUpFlags =
        lib.optional config.my.tailscale.enableSSH "--ssh";
    };

    # Enable Funnel after tailscaled is up
    systemd.services.tailscale-funnel = lib.mkIf config.my.tailscale.enableFunnel {
      description = "Enable Tailscale Funnel";
      after = [ "network-online.target" "tailscaled.service" ];
      wants = [ "network-online.target" ];
      requires = [ "tailscaled.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        ${pkgs.tailscale}/bin/tailscale funnel \
          ${toString config.my.tailscale.funnelPort}
      '';
    };

    # Firewall
    networking.firewall.trustedInterfaces = [ "tailscale0" ];

    networking.firewall.allowedTCPPorts =
      [ 22 ]
      ++ lib.optional config.my.tailscale.enableFunnel
        config.my.tailscale.funnelPort;
  };
}