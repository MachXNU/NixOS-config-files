{
  inputs,
  pkgs,
  isWork,
  isAppleSilicon,
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
        # ./discord.nix # Waiting for the issue with pnpm to be resolved
      ]
  );

  home.packages =
    with pkgs;
    [
      pavucontrol
      networkmanagerapplet
      obsidian
      thunar
      typer
    ]
    ++ (
      if !isAppleSilicon 
        then [ 
          vial
          davinci-resolve
       ] else []
    )
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
        ]
    );
}
