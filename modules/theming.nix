{
  pkgs,
  lib,
  config,
  ...
}:
let
  light_theme = "${pkgs.base16-schemes}/share/themes/penumbra-light-contrast-plus-plus.yaml";
  dark_theme = "${pkgs.base16-schemes}/share/themes/phd.yaml";

  lightColors = config.stylix.base16.mkSchemeAttrs light_theme;
  darkColors = config.stylix.base16.mkSchemeAttrs dark_theme;

  lightKitty = lightColors {
    templateRepo = config.stylix.inputs.tinted-kitty;
    target = "base16";
  };

  darkKitty = darkColors {
    templateRepo = config.stylix.inputs.tinted-kitty;
    target = "base16";
  };
in
{
  stylix = {
    enable = true;
    polarity = "light";
    autoEnable = true;
    base16Scheme = light_theme;
    fonts = {
      monospace = {
        package = import ../home-manager/fonts/MapleMono.nix { inherit pkgs; };
        name = "Maple Mono";
      };
      sizes = {
        terminal = 15;
      };
    };
  };

  xdg.configFile = {
    "kitty/light-theme.auto.conf".source = lightKitty;
    "kitty/no-preference-theme.auto.conf".source = lightKitty;
    "kitty/dark-theme.auto.conf".source = darkKitty;
  };

  specialisation = {
    light.configuration = {
      stylix = {
        polarity = lib.mkForce "light";
        base16Scheme = lib.mkForce light_theme;
      };
    };
    dark.configuration = {
      stylix = {
        polarity = lib.mkForce "dark";
        base16Scheme = lib.mkForce dark_theme;
      };
    };
  };
}
