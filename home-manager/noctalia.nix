{ pkgs, inputs, ... }:

{
  imports = [ 
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here; defaults will
      # be deep merged with these attributes.
      bar = {
        backgroundOpacity = 0.3;
        barType = "floating";
        capsuleOpacity = 0.75;
        density = "default";
        floating = true;
        position = "left";
        showCapsule = true;
        useSeparateOpacity = true;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = false;
            }
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes = {
        darkMode = false;
        generationMethod = "tonal-spot";
        manualSunrise = "06:30";
        manualSunset = "20;00";
        predefinedScheme = "Monochrome";
        schedulingMode = "manual";
        useWallpaperColors = true;
      };
      general = {
        animationSpeed = 1.35;
        dimmerOpacity = 0.3;
        forceBlackScreenCorners = true;
        iRadiusRatio = 0.98;
        radiusRatio = 0.75;
        screenRadiusRatio = 0.55;
        telemetryEnabled = false;
      };
      location = {
        monthBeforeDay = true;
        name = "Paris, France";
      };
      ui = {
        fontDefault = "DejaVu Sans";
        fontDefaultScale = 1;
        fontFixed = "Fira Mono";
        fontFixedScale = 1;
        panelBackgroundOpacity = 0.76;
        panelsAttachedToBar = true;
      };
      wallpaper = {
        directory = ./desktop/Wallpapers;
      };
    };
    # this may also be a string or a path to a JSON file,
    # but in this case must include *all* settings.
  };
}
