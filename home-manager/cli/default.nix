{
  pkgs,
  isWork,
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
      efibootmgr
      jq
      fastfetch
      jq
      zip
      unzip
    ]
    ++ (if isWork then [ samba ] else [ ]);

  home.shellAliases = {
    svim = "sudo -E ${pkgs.vim}/bin/vim";
  };
}
