{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here; defaults will
      # be deep merged with these attributes.
      appLauncher = {
        viewMode = "grid";
      };
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
              id = "SystemMonitor";
            }
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
      brightness = {
        enableDdcSupport = true;
        enforceMinimum = false;
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
            {id = "AirplaneMode";}
            {id = "Network";}
            {id = "Bluetooth";}
            {id = "DarkMode";}
          ];
          right = [
            {id = "Notifications";}
            {id = "PowerProfile";}
            {id = "KeepAwake";}
            {id = "NightLight";}
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
        lockScreenTint = 0.2;
        radiusRatio = 0.75;
        screenRadiusRatio = 0.55;
        showScreenCorners = true;
        telemetryEnabled = false;
      };
      hooks = {
        enabled = true;
        #startup = "sed -i \"/^[[:space:]]*background[[:space:]]*{/,/^[[:space:]]*}/ s|^[[:space:]]*path=.*|  path=$(noctalia-shell ipc call wallpaper get $(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name'))|\" ~/.config/hypr/hyprlock.conf";
        #wallpaperChange = "sed -i \"/^[[:space:]]*background[[:space:]]*{/,/^[[:space:]]*}/ s|^[[:space:]]*path=.*|  path=$1|\" ~/.config/hypr/hyprlock.conf";
      };
      location = {
        monthBeforeDay = true;
      };
      sessionMenu = {
        enableCountdown = false;
        largeButtonsStyle = false;
        position = "top_left";
        powerOptions = [
          {
            action = "lock";
            command = "hyprlock";
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            command = "hyprlock & (loginctl lock-session && sleep 0.5 && systemctl suspend)";
            enabled = true;
            keybind = "2";
          }
          {
            action = "hibernate";
            enabled = false;
          }
          {
            action = "reboot";
            enabled = true;
            keybind = "3";
          }
          {
            action = "logout";
            enabled = false;
          }
          {
            action = "shutdown";
            enabled = true;
            keybind = "4";
          }
          {
            action = "rebootToUefi";
            enabled = false;
          }
        ];
      };
      templates = {
        activeTemplates = [
          {
            enabled = false;
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
          {
            enabled = true;
            id = "steam";
          }
        ];
        enableUserTheming = true;
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
        enabled = false;
      };
    };

    user-templates = ''
      [config]
      # General template settings
      
      [templates.hyprland]
      input_path = '~/.config/matugen/hyprland-colors.css'
      output_path = '~/.config/hypr/noctalia/noctalia-colors.conf'

      [templates.rofi]
      input_path = '~/.config/matugen/rofi-colors.rasi'
      output_path = '~/.config/rofi/colors.rasi'
    '';
  };
}
