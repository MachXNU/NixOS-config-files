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
        backgroundOpacity = 0.35;
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
            {
              id = "MediaMini";
            }
            {
              id = "VPN";
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
              deviceNativePath = "__default__";
              displayMode = "icon-hover";
              hideIfNotDetected = true;
              id = "Battery";
              warningThreshold = 30;
              showPowerProfiles = true;
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
        generationMethod = "fruit-salad";
        manualSunrise = "06:30";
        manualSunset = "20:00";
        predefinedScheme = "Monochrome";
        schedulingMode = "manual";
        useWallpaperColors = true;
      };
      controlCenter = {
        shortcuts = {
          left = [
            { id = "Network"; }
            { id = "Bluetooth"; }
            { id = "WallpaperSelector"; }
            { id = "DarkMode"; }
          ];
          right = [            
            { id = "Notifications"; }
            { id = "PowerProfile"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
          ];
        };
      };
      dock = {
        enabled = false;
      };
      general = {
        animationSpeed = 1.35;
        avatarImage = ./.face;
        clockFormat = "h:mm AP";
        dimmerOpacity = 0.35;
        enableLockScreenCountdown = false;
        forceBlackScreenCorners = true;
        iRadiusRatio = 0.98;
        radiusRatio = 0.75;
        screenRadiusRatio = 0.55;
        showScreenCorners = true;
        telemetryEnabled = false;
      };
      location = {
        monthBeforeDay = true;
      };
      sessionMenu = {
        enableCountdown = false;
        largeButtonsStyle = false;
        position = "top_left";
      };
      templates = {
        activeTemplates = [
          {
            enabled = true;
            id = "hyprland";
          }
          {
            enabled = true;
            id = "kitty";
          }
          {
            enabled = true;
            id = "pywalfox";
          }
          {
            enabled = true;
            id = "telegram";
          }
          {
            enabled = true;
            id = "gtk";
          }
        ];
        enableUserTheming = false;
      };
      ui = {
        fontDefault = "DejaVu Sans";
        fontDefaultScale = 1;
        fontFixed = "Fira Mono";
        fontFixedScale = 1;
        #panelBackgroundOpacity = 0.76;
        panelsAttachedToBar = true;
      };
      wallpaper = {
        directory = ./desktop/Wallpapers;
        hideWallpaperFilenames = true;
      };
    };
    # this may also be a string or a path to a JSON file,
    # but in this case must include *all* settings.
  };
}
