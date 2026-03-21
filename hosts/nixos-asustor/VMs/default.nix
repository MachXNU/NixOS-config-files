{
  microvm.vms = {
    ddns = {
      config = {
        imports = [ ./ddns-vm.nix ];
      };
      autostart = true;
    };

    ente = {
      config = {
        imports = [ ./ente-vm.nix ];
      };
      autostart = true;
    };
  };

  systemd.services."microvm@ddns".serviceConfig.TimeoutStartSec = "120";
  systemd.services."microvm@ente".serviceConfig.TimeoutStartSec = "240";

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.caddy = {
    enable = true;

    virtualHosts = {

      # S3 endpoint, publicly accessible with Let's Encrypt
      "s3.ente.prestuz.freeddns.org" = {
        extraConfig = ''
          reverse_proxy http://127.0.0.1:3900 {
            #health_uri /health
            #health_port 3903
          }
        '';
      };

      "api.ente.prestuz.freeddns.org" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8080
        '';
      };

    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "42501418+MachXNU@users.noreply.github.com";
  };
}
