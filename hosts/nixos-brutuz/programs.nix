{ ... }:
{
  boot.kernelModules = [ "kvm-amd" "i2c-dev" ];
  boot.kernelParams = [ "amd_iommu=on" ];

  imports = [
    ./nvidia.nix
    ../../modules/kvm.nix
    ../../modules/virtualbox.nix
    ../../modules/steam.nix
    ../../modules/tailscale.nix
  ];

  home-manager.users.jb = { ... }: {
    programs.noctalia-shell.settings.location.name = "Rennes, France";
  };
  
  # For external monitor brightness control
  hardware.i2c.enable = true;
  users.groups.i2c = {};
  users.users.jb.extraGroups = [ "i2c" ];

  my.tailscale = {
    enable = true;
    enableSSH = true;
  };
}
