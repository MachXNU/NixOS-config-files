{pkgs, ...}: {
  home.packages = [
    pkgs.home-manager
  ];

  programs.home-manager.enable = true;
}
