{ pkgs, ... }:

{
  home.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.fira
    pkgs.fira-sans
  ];

  fonts.fontconfig.enable = true;
}
