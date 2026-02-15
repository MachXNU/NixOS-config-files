{ ... }:
{
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "amd_iommu=on" ];

  imports = [
    ./nvidia.nix
    ../../modules/kvm.nix
  ];

  home-manager.users.jb = { ... }: {
    programs.noctalia-shell.settings.location.name = "Rennes, France";
  };
}
