{ pkgs, ...}: 

{
  imports = [
    ./git.nix
    ./zsh.nix
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    file
    tree
    htop
    efibootmgr
    jq
    fastfetch
  ];
}
