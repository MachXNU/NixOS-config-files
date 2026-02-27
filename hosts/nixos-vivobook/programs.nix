{ ... }:
{
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "intel_iommu=on" ];

  imports = [
    ./nvidia.nix
    ../../modules/kvm.nix
    ../../modules/steam.nix
  ];

  home-manager.users.jb = { ... }: {
    programs.noctalia-shell.settings.location.name = "Paris, France";
  };
}
