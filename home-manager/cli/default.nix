{ pkgs, ... }: 

{
  imports = [
    # CLI plugins
    ./git
    ./zsh
  ];

  programs.fastfetch.enable = true;
}
