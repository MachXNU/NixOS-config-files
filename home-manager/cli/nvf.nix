{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

#         options = {
#           expandtab = true;
#           shiftwidth = 2;
#           softtabstop = 2;
#           tabstop = 2;
#           number = true;
#           relativenumber = true;
#           smartindent = true;
#           showmatch = true;
#           backspace = "indent,eol,start";
#         };

        lsp = {
          enable = true;

          formatOnSave = true;
          lspkind.enable = false; # Adds icons to completion items (like funcitons, packages, structs, etc.)
          lightbulb.enable = true;
          lspsaga.enable = false; # Enhancements to LSP UI, more IDE look, worth trying later
          trouble.enable = true;  # Better display of warnings and errors
          lspSignature.enable = true; # Show function signature while typing
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
            theme = "catppuccin";
          };
        };

        syntaxHighlighting = true;
      };
    };
  };
}
