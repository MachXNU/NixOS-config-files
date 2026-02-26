{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };

        # Set default indent to 4 spaces
        options = {
          tabstop = 4;
          shiftwidth = 4;
          softtabstop = 4;
          expandtab = true;
        };

        autocmds = [
          # Override indent to 2 spaces for .nix files
          {
            event = ["FileType"];
            pattern = ["nix"];
            command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2";
          }
        ];

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
          harper-ls = {
            enable = false; # English auto-correct running locally
            settings = {
              codeActions = {
                ForceStable = false; # false = experimental fixes, true = stable, tested suggestions
              };
              diagnosticSeverity = "hint"; # strict if "warning" or "error", passive if "info" or "hint"
              dialect = "American"; # or British, etc. English only
              fileDictPath = "";
              ignoredLintsPath = {}; # disable annoying rules, see later
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
          clang.enable = false;
          markdown.enable = true;
          nix.enable = true;
          python.enable = false;
        };

        visuals = {
          nvim-scrollbar.enable = false;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          blink-indent.enable = true;
          indent-blankline.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

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

        notes = {
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = false;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
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
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };

        assistant = {
          chatgpt.enable = false;
          copilot = {
            enable = false;
            cmp.enable = false;
          };
          codecompanion-nvim.enable = false;
          avante-nvim.enable = false;
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
      };
    };
  };
}
