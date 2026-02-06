{ pkgs, ... }: 

{
  imports = [
    ./git
    ./zsh
  ];

  programs.fastfetch.enable = true;
}
