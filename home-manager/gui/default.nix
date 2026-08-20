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
    ./kitty.nix
    ./firefox
  ]
  ++ lib.optionals isWork [
    ./picoscope.nix
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
    ++ lib.optionals (!isWork) [
      blender
      inputs.concord.packages.${pkgs.system}.default
    ]
    ++ lib.optionals (!isWork && isLinux) [
      telegram-desktop
      haruna
      ffmpeg
      davinci-resolve
    ]
    ++ lib.optionals (!isWork && !isLinux) [
      iina
    ];
}
