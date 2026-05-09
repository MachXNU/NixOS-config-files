{ config, pkgs, lib, ... }:
{
  networking.hostName = "nixos-garage";
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
    device = "Asustor-Garage-Secrets";
    fsType = "virtiofs";
  };

  fileSystems."/var/lib/garage/data" = {
    device = "/dev/disk/by-uuid/b8c0ccb1-b1eb-48e3-9556-f1a4b8d042c4";
    fsType = "ext4";
  };

  users.users.garage = {
    isSystemUser = true;
    group = "garage";
  };

  users.groups.garage = {};

  imports = [
    ../../modules/tailscale.nix
    ../../modules/garage.nix
  ];

  my.tailscale = {
    enable = true;
    enableFunnel = true;
    funnelPort = 3900;
  };
  
  my.garage = {
    enable = true;
    region = "garage-paris";
  };
}
