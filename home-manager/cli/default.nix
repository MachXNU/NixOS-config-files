{
  lib,
  pkgs,
  isWork,
  isLinux,
  ...
}:

{
  imports = [
    ./fastfetch.nix
    ./git.nix
    ./neovim.nix
    ./nvf.nix
    ./nh.nix
    ./ranger.nix
    ./ssh.nix
    ./zsh.nix
  ];

  home.packages =
    with pkgs;
    [
      bat
      file
      home-manager
      tree
      htop
      jq
      zip
      unzip
      usbutils
      restic
      fzf
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
