{
  inputs,
  pkgs,
  isWork,
  ...
}:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
    ./kitty.nix
    ./firefox
  ]
  ++ (
    if isWork then
      [
        ./picoscope.nix
      ]
    else
      [
        ./discord.nix
      ]
  );

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
        [
          telegram-desktop
          haruna
          ffmpeg
          davinci-resolve
        ]
    );
}
