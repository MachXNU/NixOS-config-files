{
  pkgs,
  isWork,
  ...
}:
{
  imports = [
    ./kitty.nix
    ./firefox
  ]
  ++ (if isWork then [ ./picoscope.nix ] else [ ]);

  home.packages =
    with pkgs;
    [
      pavucontrol
      networkmanagerapplet
      obsidian
    ]
    ++ (
      if isWork then
        [
          thunderbird
        ]
      else
        [ telegram-desktop ]
    );
}
