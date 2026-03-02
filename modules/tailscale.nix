{
  services.tailscale.enable = true;
  # services.tailscale.authKey = "<auth-key>";

  # Firewall
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.allowedTCPPorts = [ 22 ];
}
