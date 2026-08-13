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

in
{
  stylix = {
    enable = true;
    polarity = "dark";
    autoEnable = true;
    base16Scheme = dark_theme;
    fonts = {
      monospace = {
        package = import ../home-manager/fonts/MapleMono.nix { inherit pkgs; };
        name = "Maple Mono";
      };
      sizes = {
        terminal = 15;
      };
    };
    targets = {
      nvf.enable = false;
    };
  };

  xdg.configFile = {
    "kitty/light-theme.auto.conf".source = lightKitty;
    "kitty/no-preference-theme.auto.conf".source = lightKitty;
    "kitty/dark-theme.auto.conf".source = darkKitty;
  };

  programs.nvf.settings.vim = {
    startPlugins = [
      pkgs.vimPlugins.mini-base16
    ];

    luaConfigRC.theme = ''
      local palettes = {
        light = ${base16ToLua lightColors},
        dark = ${base16ToLua darkColors},
      }

      local function apply_theme_overrides(palette)
        local bg = vim.api.nvim_get_hl(0, {
          name = "Normal",
        }).bg

        local muted_fg = palette.base04

        if not bg then
          return
        end

        local function set_bg_preserve_fg(group, bg)
          local hl = vim.api.nvim_get_hl(0, {
            name = group,
            link = false,
          })

          vim.api.nvim_set_hl(0, group, {
            fg = hl.fg,
            bg = bg,
          })
        end

        local groups = {
          -- Line-number gutter
          "CursorLineNr",
          "SignColumn",

          -- Treesitter context
          "TreesitterContext",
          "TreesitterContextBottom",
          "TreesitterContextLineNumber",
          "TreesitterContextSeparator",

          -- Window / split separators
          "WinSeparator",
          "VertSplit",

          -- Floating windows
          "FloatBorder",
          "NormalFloat",

          -- Tabline
          "TabLine",
          "TabLineFill",
          "TabLineSel",
        }

        local line_number_groups = {
          "LineNr",
          "LineNrAbove",
          "LineNrBelow",
        }

        for _, group in ipairs(groups) do
          vim.api.nvim_set_hl(0, group, {
            bg = bg,
          })
        end

        for _, group in ipairs(line_number_groups) do
          vim.api.nvim_set_hl(0, group, {
            fg = muted_fg,
            bg = bg,
          })
        end
      end

      local function apply_theme_with_overrides()
        local palette = palettes[vim.o.background]

        require("mini.base16").setup({
          palette = palette,
          plugins = {
            default = false,
          },
        })

        apply_theme_overrides(palette)
      end

      apply_theme_with_overrides()

      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        callback = apply_theme_with_overrides,
      })
    '';
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
