{ config, ... }:

{
  imports = [
    ./hdd-spindown.nix
    ../../modules/tailscale.nix
    ./secrets.nix
  ];

  my.tailscale = {
    enable = true;
    authKeyFile =
      config.age.secrets.asustor-tailscale-authkey.path;
    enableSSH = true;
  };
}
