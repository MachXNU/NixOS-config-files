{ pkgs, ...}: 

{
  imports = [
    ./git.nix
    ./neovim.nix
    ./nvf.nix
    ./ranger.nix
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
    protonvpn-gui
    jq
    zip
    unzip
  ];
}
