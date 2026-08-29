{
  pkgs,
  lib,
  inputs,
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

  base16ToLua =
    colors: with colors.withHashtag; ''
      {
        base00 = "${base00}",
        base01 = "${base01}",
        base02 = "${base02}",
        base03 = "${base03}",
        base04 = "${base04}",
        base05 = "${base05}",
        base06 = "${base06}",
        base07 = "${base07}",
        base08 = "${base08}",
        base09 = "${base09}",
        base0A = "${base0A}",
        base0B = "${base0B}",
        base0C = "${base0C}",
        base0D = "${base0D}",
        base0E = "${base0E}",
        base0F = "${base0F}",
      }
    '';

  mkColorscheme =
    {
      name,
      colors,
    }:
    pkgs.vimUtils.buildVimPlugin {
      pname = name;
      version = "1.0.0";

      src = pkgs.runCommand name { } ''
        mkdir -p $out/colors

        cat > $out/colors/${name}.lua <<'EOF'
        local palette = ${base16ToLua colors}

        require("mini.base16").setup({
          palette = palette,
          plugins = {
            default = false,
          },
        })

        local bg = palette.base00
        local muted_fg = palette.base04

        local function set_bg(group)
          local hl = vim.api.nvim_get_hl(0, {
            name = group,
            link = false,
          })

          vim.api.nvim_set_hl(0, group, {
            fg = hl.fg,
            bg = bg,
          })
        end

        for _, group in ipairs({
          -- Line-number gutter
          "CursorLineNr",
          "SignColumn",

          -- Treesitter context
          "TreesitterContext",
          "TreesitterContextBottom",
          "TreesitterContextSeparator",

          -- Window / split separators
          "WinSeparator",
          "VertSplit",

          -- Floating windows
          "FloatBorder",
          "NormalFloat",

          -- Diagnostic floating windows
          "DiagnosticFloatingError",
          "DiagnosticFloatingWarn",
          "DiagnosticFloatingInfo",
          "DiagnosticFloatingHint",
          "DiagnosticFloatingOk",

          -- Tabline
          "TabLine",
          "TabLineFill",
          "TabLineSel",
        }) do
          set_bg(group)
        end

        for _, group in ipairs({
          "LineNr",
          "LineNrAbove",
          "LineNrBelow",
          "TreesitterContextLineNumber",
        }) do
          vim.api.nvim_set_hl(0, group, {
            fg = muted_fg,
            bg = bg,
          })
        end

        vim.g.colors_name = "${name}"
        EOF
      '';
    };

  mytheme-light = mkColorscheme {
    name = "mytheme-light";
    colors = lightColors;
  };

  mytheme-dark = mkColorscheme {
    name = "mytheme-dark";
    colors = darkColors;
  };

  mkThemeNixTheme =
    {
      name,
      colors,
    }:
    inputs.themeNix.custom {
      inherit name;

      author = "local";

      base00 = colors.base00;
      base01 = colors.base01;
      base02 = colors.base02;
      base03 = colors.base03;
      base04 = colors.base04;
      base05 = colors.base05;
      base06 = colors.base06;
      base07 = colors.base07;
      base08 = colors.base08;
      base09 = colors.base09;
      base0A = colors.base0A;
      base0B = colors.base0B;
      base0C = colors.base0C;
      base0D = colors.base0D;
      base0E = colors.base0E;
      base0F = colors.base0F;
    };

  lightFirefoxTheme = builtins.fromJSON (
    (mkThemeNixTheme {
      name = "MyTheme Light";
      colors = lightColors;
    }).firefoxTheme
  );

  darkFirefoxTheme = builtins.fromJSON (
    (mkThemeNixTheme {
      name = "MyTheme Dark";
      colors = darkColors;
    }).firefoxTheme
  );

  addonId = "mytheme-base16@example.com";

  firefoxTheme =
    pkgs.runCommand "firefox-mytheme"
      {
        passthru = {
          inherit addonId;
        };
      }
      ''
        mkdir -p "$out"

        cat > manifest.json <<'EOF'
        ${builtins.toJSON {
          manifest_version = 2;

          name = "MyTheme";
          version = "1.0.0";

          browser_specific_settings = {
            gecko = {
              id = addonId;
            };
          };

          theme = {
            colors = lightFirefoxTheme.colors;
          };

          dark_theme = {
            colors = darkFirefoxTheme.colors;
          };
        }}
        EOF

        ${pkgs.zip}/bin/zip -q "$out/mytheme.xpi" manifest.json
      '';
  darkReaderTheme =
    {
      light,
      dark,
    }:
    {
      mode = 1;
      brightness = 100;
      contrast = 100;
      grayscale = 0;
      sepia = 0;

      useFont = false;
      fontFamily = "Maple Mono";
      textStroke = 0;

      engine = "dynamicTheme";
      stylesheet = "";

      lightSchemeBackgroundColor = "#${light.base00}";
      lightSchemeTextColor = "#${light.base07}";

      darkSchemeBackgroundColor = "#${dark.base00}";
      darkSchemeTextColor = "#${dark.base06}";

      scrollbarColor = "#${dark.base01}";
      selectionColor = "#${dark.base02}";

      styleSystemControls = true;
    };

  mkNoctaliaPalette =
    colors: with colors.withHashtag; {
      mPrimary = base0D;
      mOnPrimary = base00;

      mSecondary = base0E;
      mOnSecondary = base00;

      mTertiary = base0C;
      mOnTertiary = base00;

      mError = base08;
      mOnError = base00;

      mSurface = base00;
      mOnSurface = base05;

      mHover = base0C;
      mOnHover = base00;

      mSurfaceVariant = base01;
      mOnSurfaceVariant = base04;

      mOutline = base03;
      mShadow = base00;

      terminal = {
        foreground = base05;
        background = base00;
        cursor = base05;
        cursorText = base00;
        selectionFg = base05;
        selectionBg = base02;

        normal = {
          black = base00;
          red = base08;
          green = base0B;
          yellow = base0A;
          blue = base0D;
          magenta = base0E;
          cyan = base0C;
          white = base05;
        };

        bright = {
          black = base03;
          red = base08;
          green = base0B;
          yellow = base0A;
          blue = base0D;
          magenta = base0E;
          cyan = base0C;
          white = base07;
        };
      };
    };

  noctaliaPalette = {
    dark = mkNoctaliaPalette darkColors;
    light = mkNoctaliaPalette lightColors;
  };

  noctaliaPaletteFile = pkgs.writeText "mytheme.json" (builtins.toJSON noctaliaPalette);

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
        terminal = 12;
      };
    };
    targets = {
      nvf.enable = false;
      firefox.enable = false;
      noctalia.enable = false;
    };
  };

  xdg.configFile = {
    "kitty/light-theme.auto.conf".source = lightKitty;
    "kitty/no-preference-theme.auto.conf".source = lightKitty;
    "kitty/dark-theme.auto.conf".source = darkKitty;
  };

  programs.nvf.settings.vim = {
    theme.enable = false;

    startPlugins = [
      pkgs.vimPlugins.mini-base16

      mytheme-light
      mytheme-dark
    ];

    luaConfigRC.theme = ''
      local themes = {
        light = "mytheme-light",
        dark = "mytheme-dark",
      }

      local function apply_theme()
        vim.cmd.colorscheme(themes[vim.o.background])
      end

      local function reload_bufferline()
        require("bufferline").setup(
          ${lib.generators.toLua { } config.programs.nvf.settings.vim.tabline.nvimBufferline.setupOpts}
        )
        require("bufferline.highlights").reset_icon_hl_cache()
      end

      apply_theme()

      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        callback = function()
          apply_theme()
          reload_bufferline()
        end,
      })
    '';
  };

  programs.firefox.policies = {
    ExtensionSettings = {
      ${addonId} = {
        #installation_mode = "force_installed";
        install_url = "file://${firefoxTheme}/mytheme.xpi";
      };
    };
  };

  programs.firefox.profiles.user.extensions = {
    force = true;

    settings."addon@darkreader.org" = {
      force = true;

      settings = {
        schemeVersion = 2;
        enabled = true;

        theme = darkReaderTheme {
          light = lightColors;
          dark = darkColors;
        };

        siteList = [ ];
        siteListEnabled = [ ];
        applyToListedOnly = false;
        enabledFor = [ ];
        disabledFor = [
          "tinted-theming.github.io"
          "example.com"
        ];

        automation = {
          enabled = true;
          mode = "system";
          behavior = "Scheme";
        };
        changeBrowserTheme = false;

        syncSettings = false;
        syncSitesFixes = false;

        enableForPDF = true;
        enableForProtectedPages = false;
        enableContextMenus = true;
        notifyOfNews = false;
        previewNewDesign = true;
      };
    };
  };

  xdg.configFile."noctalia/palettes/mytheme.json".source = noctaliaPaletteFile;

  programs.noctalia.settings.theme = {
    source = "custom";
    custom_palette = "mytheme";
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
