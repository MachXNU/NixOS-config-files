{ pkgs, ... }:

{
  home.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;
}
