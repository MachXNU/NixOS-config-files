{ config, pkgs, lib, ... }:

{
  networking.hostName = "ddns-vm";
  system.stateVersion = "25.11";

  microvm = {
    hypervisor = "qemu";
    vsock.cid = 4;
    vcpu = 1;
    mem = 512;

    shares = [
      {
        proto = "virtiofs";
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
    ];
    writableStoreOverlay = "/nix/.rw-store";

    interfaces = [{
      type = "tap";
      id = "microvm-ddns";
      mac = "02:00:00:00:00:01";
    }];
  };

  systemd.network.enable = true;

  systemd.network.networks."10-eth0" = {
    matchConfig.Name = "e*";
    networkConfig = {
      Address = "192.168.1.50/24";
      Gateway = "192.168.1.1";
      DNS = [ "192.168.1.1" ];
    };
  };

  users.users.ddns = {
    isNormalUser = true;
    # home = "/persist/gogcli";
    # createHome = true;
    group = "users";
    password = "ddns";
    # authorized_keys は /run/secrets/authorized-keys (command= 付き) のみ使用
    # 個人鍵を置くと command= 制限をバイパスしてフルシェルが取れてしまう
  };
  users.groups.ddns = {};

  # systemd.tmpfiles.rules = [
  #   "d /persist/gogcli 0755 gogcli gogcli -"
  #   "d /persist/gogcli/.config/gogcli 0700 gogcli gogcli -"
  #   "d /persist/gogcli/.config/gogcli/keyring 0700 gogcli gogcli -"
  #   "Z /persist/gogcli/.config/gogcli 0700 gogcli gogcli -"
  # ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

}
