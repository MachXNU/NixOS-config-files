{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = true;
          level = 16;
          logFile = "/tmp/nvim.log";
        };

        # Set default indent to 4 spaces
        options = {
          tabstop = 4;
          shiftwidth = 4;
          softtabstop = 4;
          expandtab = true;

          # case-(in)sensitive search
          smartcase = true;
          ignorecase = true;

          wrap = true;
          textwidth = 85;
          colorcolumn = "+1";
          formatoptions = "qrn1c";
        };

        autocmds = [
          # Override indent to 2 spaces for .nix files
          {
            event = [ "FileType" ];
            pattern = [ "nix" ];
            command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2";
          }
        ];

        extraPlugins = {
          onenord = {
            package = pkgs.vimPlugins.onenord-nvim;
          };
        };

        lsp = {
          # This must be enabled for the language modules to hook into
          # the LSP API.
          enable = true;

          formatOnSave = true;
          lspkind.enable = false; # adds icons to autocompletion (fcts, class, structs, etc.)
          lightbulb.enable = true;
          lspsaga.enable = false; # improves Nvim's default LSP experience
          trouble.enable = true; # shows diagnostics, and warnings to help debug
          lspSignature.enable = false; # conflicts with blink in maximal
          otter-nvim.enable = false; # LSP support for files with multiple programming languages
          nvim-docs-view.enable = false;
          presets = {
            harper.enable = true;
          };
          servers = {
            harper = {
              settings = {
                codeActions = {
                  ForceStable = false; # false = experimental fixes, true = stable, tested suggestions
                };
                diagnosticSeverity = "hint"; # strict if "warning" or "error", passive if "info" or "hint"
                dialect = "American"; # or British, etc. English only
                fileDictPath = "";
                #ignoredLintsPath = {}; # disable annoying rules, see later
                isolateEnglish = true; # only check English blocks, tries to lint everything if true
                linters = {
                  BoringWords = true; # flags overused words like very, really, stuff, etc.
                  PossessiveNoun = true; # Alices friend -> Alice's friend
                  SentenceCapitalization = false;
                  SpellCheck = true;
                };
                markdown = {
                  IgnoreLinkTitle = true; # [link text](url "Title here")
                };
                maxFileLength = 120000; # lower if slow
                userDictPath = "";
                workspaceDictPath = "";
              };
            };
          };
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        # Languages with LSP support
        # See nvf options for more details
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          bash.enable = false;
          clang = {
            enable = true;
            lsp = {
              enable = true;
              servers = [ "clangd" ];
            };
          };
          markdown.enable = true;
          nix = {
            enable = true;
            format = {
              enable = true;
              type = [ "nixfmt" ];
            };
            lsp = {
              enable = true;
              servers = [ "nixd" ];
            };
          };
          python = {
            enable = true;
            format = {
              enable = true;
              type = [ "ruff" ];
            };
            lsp = {
              enable = true;
              servers = [
                "basedpyright"
                "ruff"
              ];
            };
          };
        };

        visuals = {
          nvim-scrollbar.enable = false;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          blink-indent.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "auto";
          };
        };

        #theme = {
        #  enable = true;
        #  name = "onenord";
        #  transparent = false;
        #};

        autopairs.nvim-autopairs.enable = true;

        # nvf provides various autocomplete options. The tried and tested nvim-cmp
        # is enabled in default package, because it does not trigger a build. We
        # enable blink-cmp in maximal because it needs to build its rust fuzzy
        # matcher library.
        autocomplete = {
          nvim-cmp.enable = false;
          blink-cmp = {
            enable = true;
            setupOpts.signature.enabled = true;
          };
        };

        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
          neogit.enable = false;
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = false; # lighter, faster, and uses lua for configuration
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = false;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = false;
        };

        keymaps = [
          {
            key = "]d";
            mode = "n";
            lua = true;
            action = ''
              function()
                vim.diagnostic.jump({ count = 1 })
                vim.defer_fn(function()
                  vim.diagnostic.open_float(nil, {
                    focus = false,
                    border = "rounded",
                  })
                end, 50)
              end
            '';
            desc = "Next diagnostic + popup";
          }
          {
            key = "[d";
            mode = "n";
            lua = true;
            action = ''
              function()
                vim.diagnostic.jump({ count = -1 })
                vim.defer_fn(function()
                  vim.diagnostic.open_float(nil, {
                    focus = false,
                    border = "rounded",
                  })
                end, 50)
              end
            '';
            desc = "Prev diagnostic + popup";
          }
          {
            key = "gl";
            mode = "n";
            lua = true;
            action = ''
              function()
                vim.diagnostic.open_float(nil, {
                  focus = false,
                  border = "rounded",
                  source = "always",
                })
              end
            '';
            desc = "Show line diagnostic";
          }
          {
            key = "/";
            mode = "n";
            action = "/\\v";
            desc = "Fix vim's regex handling";
          }
          {
            key = "/";
            mode = "v";
            action = "/\\v";
            desc = "Fix vim's regex handling";
          }
          {
            key = "j";
            mode = "n";
            action = "gj";
          }
          {
            key = "k";
            mode = "n";
            action = "gk";
          }
          {
            key = "<leader>fe";
            mode = "n";
            action = "<cmd>Neotree toggle<CR>";
          }
          {
            key = "<leader>fr";
            mode = "n";
            action = "<cmd>Neotree reveal<CR>";
          }
          {
            key = "<leader>fo";
            mode = "n";
            action = "<cmd>Neotree focus<CR>";
          }
        ];

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim.enable = false;
          icon-picker.enable = false;
          surround.enable = false;
          multicursors.enable = false;
          nvim-biscuits.enable = false;
          grug-far-nvim.enable = false;

          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = false;
          };
          images = {
            image-nvim.enable = false;
            img-clip.enable = false;
          };
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = false;
          colorizer.enable = true;
          modes-nvim.enable = false;
          illuminate.enable = true;
          breadcrumbs = {
            enable = false;
            navbuddy.enable = false;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "110";
              ruby = "120";
              java = "130";
              go = [
                "90"
                "130"
              ];
            };
          };
          fastaction.enable = false; # broken
        };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = false;
        };

        luaConfigPost = ''
          local function get_dark_mode()
            local handle = io.popen(
              "noctalia-shell ipc call state all | jq -r '.settings.colorSchemes.darkMode'"
            )

            local result = handle and handle:read("*a") or "true"
            if handle then handle:close() end

            result = result:gsub("%s+", "")
            return result == "true"
          end

          local function apply_light_overrides()
            local bg = "#eceff4"

            local groups = {
              "Normal",
              "NormalNC",
              "NormalFloat",
              "FloatBorder",
              "SignColumn",
              "EndOfBuffer",
              "CursorLine",

              "TreesitterContext",
              "TreesitterContextBottom",
              "TreesitterContextLineNumber",
              "TreesitterContextSeparator",
            }

            for _, g in ipairs(groups) do
              vim.api.nvim_set_hl(0, g, { bg = bg })
            end
          end

          local function apply_dark_overrides()
            local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
            if not bg then bg = "NONE" end

            local groups = {
              -- treesitter context
              "TreesitterContext",
              "TreesitterContextBottom",
              "TreesitterContextLineNumber",
              "TreesitterContextSeparator",

              -- window / split separators (THIS is the missing piece)
              "WinSeparator",
              "VertSplit",

              -- floating context edge cases
              "FloatBorder",
              "NormalFloat",
            }

            for _, g in ipairs(groups) do
              vim.api.nvim_set_hl(0, g, { bg = bg })
            end
          end

          local function apply_theme()
            local is_dark = get_dark_mode()

            vim.o.background = is_dark and "dark" or "light"

            require("onenord").setup()
            vim.cmd("colorscheme onenord")

            if is_dark then
              apply_dark_overrides()
            else
              apply_light_overrides()
            end
          end

          -- initial load
          apply_theme()

          -- reapply if anything resets colorscheme later
          vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
              apply_theme()
            end,
          })
        '';
      };
    };
  };

  home.packages = with pkgs; [
    nixfmt
    nixd
  ];
}
