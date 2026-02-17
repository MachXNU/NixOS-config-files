{ pkgs, ...}: 

{
  imports = [
    ./git.nix
    ./neovim.nix
    ./ssh.nix
    ./zsh.nix
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
