{
  microvm.vms = {
    # ddns = {
    #   config = {
    #     imports = [ ./ddns-vm.nix ];
    #   };
    #   autostart = true;
    # };

    ente = {
      config = {
        imports = [ ./ente-vm.nix ];
      };
      autostart = true;
    };
  };

  systemd.services."microvm@ddns".serviceConfig.TimeoutStartSec = "120";

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
