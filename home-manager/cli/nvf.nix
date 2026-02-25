{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        options = {
#           expandtab = true;
#           shiftwidth = 2;
#           softtabstop = 2;
#           tabstop = 2;
#           number = true;
#           relativenumber = true;
#           smartindent = true;
#           showmatch = true;
#           backspace = "indent,eol,start";
          shada = "!,'100,<50,s10,h";  
        };

        lsp = {
          enable = true;

          formatOnSave = true;
          lspkind.enable = true; # Adds icons to completion items (like funcitons, packages, structs, etc.)
          lightbulb.enable = true;
          lspsaga.enable = false; # Enhancements to LSP UI, more IDE look, worth trying later
          trouble.enable = true;  # Better display of warnings and errors
          lspSignature.enable = false; # Show function signature while typing, clashes with blink-cmp
          otter-nvim.enable = false;  # LSP support for files with different languages
          nvim-docs-view.enable = false;
          harper-ls.enable = true; # Grammar check running locally
        };
        
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          bash.enable = true;
          clang.enable = true;
          json.enable = true;
          markdown.enable = true;
          nix.enable = true;
          python.enable = true;
          qml.enable = true;
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true; # smooth scrolling
          fidget-nvim.enable = true;   # nice UI for notifications and LSP progress messages

          highlight-undo.enable = true;   # highlight changed text after any action not in insert mode (like undo/redo)
          blink-indent.enable = true;     # vertical indent lines
          indent-blankline.enable = true; # identation guides, might look wierd
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "auto";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };

        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;

          mappings = {
            next = "<C-n>";
            previous = "<C-p>";
            confirm = "<CR>";
            complete = "<C-Space>";
            close = "<C-e>";
          };

          setupOpts = {
            fuzzy.implementation = "prefer_rust";
            completion.documentation.auto_show = true;
            keymap.preset = "default";
          };
        };

        autopairs.nvim-autopairs.enable = true;

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
          codewindow.enable = true;  # might get annoying
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = true;  # really useful?
        };

        utility = {
          ccc.enable = true;                  # color picker
          vim-wakatime.enable = false;        # tracks coding time
          diffview-nvim.enable = true;        # view git diff nicely
          yanky-nvim.enable = true;           # enhanced yank/paste, history
          icon-picker.enable = true;          # emoji selector    
          surround.enable = true;             # wrap content in quotes, brackets, etc.
          multicursors.enable = false;        # what the hell is even that?
          undotree.enable = false;            # visualize undo history as a tree
          nvim-biscuits.enable = true;        # show current fct/class inline at the top of a block
          grug-far-nvim.enable = false;       # project-wide search and replace

          motion = {
            hop.enable = true;                # jump anywhere on screen using hint characters
            leap.enable = true;               # fast 2 characters jump motion
            precognition.enable = true;       # shows suggested motions (teaches VIM navigation)
          };

          images = {
            image-nvim.enable = true;         # render images inside Neovim buffer
            img-clip.enable = true;           # paste images from clipboard into markdown/org/etc.
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
        };

        comments = {
          comment-nvim.enable = true;
        };
      };
    };
  };
}
