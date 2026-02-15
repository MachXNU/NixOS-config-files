{ pkgs, ... }: 
{
  imports = [
    # GUI apps
    ./kitty.nix
    ./firefox
  ];

  home.packages = with pkgs; [
    pavucontrol
    networkmanagerapplet
    telegram-desktop
  ];
}
