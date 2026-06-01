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
      if isWork
      then [
        thunderbird
        picoscope
      ]
      else [telegram-desktop]
    );
}
