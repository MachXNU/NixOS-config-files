{ pkgs, ... }:
let
  stretchpro = pkgs.callPackage ./stretchpro.nix { inherit pkgs; };
  suisseintlmono = pkgs.callPackage ./SuisseIntlMono.nix { inherit pkgs; };
  sfproregular = pkgs.callPackage ./SFProRegular.nix { inherit pkgs; };
  sfprobold = pkgs.callPackage ./SFProBold.nix { inherit pkgs; };
in
{
  home.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.fira
    pkgs.fira-sans
    stretchpro
    suisseintlmono
    sfproregular
    sfprobold
  ];

  fonts.fontconfig.enable = true;
}
