{
  inputs,
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
      obsidian
    ]
    ++ (
      if isLinux then [
        pavucontrol
        networkmanagerapplet
      ] else []
    ) ++ (
      if isWork then
        [
          thunderbird
        ]
      else
        ( if isLinux then [
          telegram-desktop
          haruna
          ffmpeg
          davinci-resolve
        ] else [] )
    );
}
