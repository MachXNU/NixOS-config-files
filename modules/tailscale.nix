{ config, lib, pkgs, ... }:

{
  options.my.tailscale = {
    enable = lib.mkEnableOption "Tailscale";
    authKeyFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to Tailscale auth key file.";
    };
    enableSSH = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Tailscale SSH (--ssh).";
    };
  };

  config = {
    services.tailscale = {
      enable = true;
      authKeyFile = config.my.tailscale.authKeyFile;
      extraUpFlags =
        lib.optional config.my.tailscale.enableSSH "--ssh";
    };

    # Firewall
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
