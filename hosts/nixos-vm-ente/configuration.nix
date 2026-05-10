{ config, pkgs, lib, ... }:
{
  networking.hostName = "nixos-vm-ente";
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
    device = "HPOmen-Ente-Secrets";
    fsType = "virtiofs";
  };

  imports = [
    ../../modules/tailscale.nix
  ];

  my.tailscale = {
    enable = true;
    enableFunnel = true;
    funnelPort = 3900;
  };

  services.postgresql = {
    enable = true;
    dataDir = "/data/postgres";
    package = pkgs.postgresql_15;
    authentication = pkgs.lib.mkOverride 10 ''
      local all postgres         peer map=postgres
      local all all              md5
      host  all all 127.0.0.1/32 md5
      host  all all ::1/128      md5
    '';
  };
}
