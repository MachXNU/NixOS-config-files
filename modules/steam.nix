{ pkgs, lib, config, ... }:
let
  materialTheme = pkgs.stdenv.mkDerivation {
    pname = "Material-Theme for Millennium";
    version = "1.2.1";

    src = pkgs.fetchFromGitHub {
      owner = "kuska1";
      repo = "Material-Theme";
      rev = "b1aa00ec7250327fda88d2fa555fdd23164e0187";
      sha256 = "sha256-FJemv26E/tFcD7JIE5yVIp9W+t0K10TrMyVDz2fr06s=";
    };

    patchPhase = ''
      runHook prePatch

      sed -Ei '/--corner-radius-none:/! s/(--corner-radius-[a-z-]+:)[[:space:]]*[0-9]+px;/\1 2px;/g' css/main/main.css

      runHook postPatch
    '';

    installPhase = ''
      mkdir -p $out
      cp -r . $out/
    '';
  };
in
{
  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  home-manager.users.jb = { pkgs, lib, config, ... }: {
    xdg.configFile."matugen/millennium-template.css".text = ''
      :root {
        --theme-color: "Matugen";
        --hue-rotate: 220deg;
        <* for name, value in colors *>
        --md-sys-color-{{name | replace: "_", "-" }}: {{value.default.rgb}};
        <* endfor *>
      }
    '';

    # copy the theme folder outside the Nix store, to be writable
    home.activation.installMaterialTheme =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        target="$HOME/.steam/steam/steamui/skins/Material-Theme"

        if [ ! -d "$target" ]; then
          mkdir -p "$(dirname "$target")"
          cp -r ${materialTheme} "$target"
          chmod -R u+w "$target"
        fi
      '';

    xdg.configFile."millennium/config.json".text = builtins.toJSON {
      general = {
        accentColor = "DEFAULT_ACCENT_COLOR";
        checkForMillenniumUpdates = true;
        checkForPluginAndThemeUpdates = true;
        injectCSS = true;
        injectJavascript = true;
        millenniumUpdateChannel = "stable";
        onMillenniumUpdate = 1;
        shouldShowThemePluginUpdateNotifications = true;
      };

      misc = {
        hasShownWelcomeModal = true;
      };

      notifications = {
        showNotifications = true;
        showPluginNotifications = true;
        showUpdateNotifications = true;
      };

      themes = {
        activeTheme = "Material-Theme";
        allowedScripts = true;
        allowedStyles = true;

        conditions = {
          "Material-Theme" = {
            " - Show Balance in menu after Hover?" = "yes";
            " - Show Balance near name after hover?" = "yes";
            " - Show Name after Hover?" = "yes";
            " - Show Name in account change after Hover?" = "yes";
            "Account Balance in Menu" = "Blur";
            "Account Balance near Account Name" = "Blur";
            "Account Name in Account Change" = "Blur";
            "Account Name in Menu" = "Blur";
            "Achievements Icons Shape" = "Square";
            "Animations" = "Enabled";
            "Appearance" = "Light";
            "Badges for Contributors" = "yes";
            "Big Game Card Hover Animation" = "Default";
            "Bottom Bar Style" = "Default";
            "Color" = "Matugen";
            "Disable Max Hero Image Size" = "no";
            "Font" = "Open Sans";
            "Game Card Hover Animation" = "Default";
            "Game Icons Shape" = "Square";
            "Groups/Curators Picture Shape" = "Square";
            "Header Always Visible" = "yes";
            "Hide Big Picture Mode Button" = "yes";
            "Hide News Button" = "no";
            "Hide Notifications Button" = "no";
            "Hide Scrollbar" = "yes";
            "Hide Window Control Buttons" = "no";
            "Icons" = "Default";
            "Loading Style" = "Default";
            "Online Indicator" = "Default";
            "Profile Picture Shape" = "Square";
            "Rare Achievements based on Source Color" = "yes";
            "Remove Shiny Effect" = "Yes";
            "Swap Dialog Buttons" = "yes";
            "Toolbar Account" = "Default";
            "Toolbar Icon" = "Steam";
            "Toolbar Title" = "Default";
            "Toolbar Title Based on Icon" = "yes";
            "Use Experimental Features" = "no";
            "What's New" = "Compact";
          };
        };
      };
    };
  };
}
