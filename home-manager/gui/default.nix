{
  pkgs,
  isWork,
  ...
}: {
  imports = [
    ./kitty.nix
    ./firefox
  ];

  home.packages = with pkgs;
    [
      pavucontrol
      networkmanagerapplet
      obsidian
    ]
    ++ (
      if !isWork
      then [telegram-desktop]
      else []
    );
}
