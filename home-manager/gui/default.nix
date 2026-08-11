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
    inputs.nixcord.homeModules.nixcord
    ./kitty.nix
    ./firefox
  ]
  ++ lib.optionals isWork [
    ./picoscope.nix
  ]
  ++ lib.optionals (!isWork) [
    ./discord.nix
  ];

  home.packages =
    with pkgs;
    [
      obsidian
    ]
    ++ lib.optionals isLinux [
      pavucontrol
      networkmanagerapplet
      thunar
      typer
      vial
    ]
    ++ lib.optionals isWork [
      thunderbird
    ]
    ++ lib.optionals (!isWork && isLinux) [
      telegram-desktop
      haruna
      ffmpeg
      davinci-resolve
    ];
}
