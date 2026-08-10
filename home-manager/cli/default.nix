{
  inputs,
  lib,
  pkgs,
  isWork,
  isLinux,
  ...
}:

{
  imports = [
    ./home-manager.nix
    ./git.nix
    ./neovim.nix
    ./nvf.nix
    ./ranger.nix
    ./ssh.nix
    ./zsh.nix
  ];

  home.packages =
    with pkgs;
    [
      file
      tree
      htop
      jq
      fastfetch
      zip
      unzip
    ]
    ++ lib.optionals isLinux [
      efibootmgr
    ]
    ++ lib.optionals isWork [
      samba
    ];

  home.shellAliases = {
    svim = "sudo -E ${pkgs.vim}/bin/vim";
  };
}
