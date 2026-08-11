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
    ./ranger.nix
    ./ssh.nix
    ./zsh.nix
  ];

  home.packages =
    with pkgs;
    [
      bat
      file
      tree
      htop
      jq
      fastfetch
      zip
      unzip
      usbutils
      restic
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
