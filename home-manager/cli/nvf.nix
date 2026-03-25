{ pkgs, ...}:

{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        options = {
          expandtab = true;
          shiftwidth = 2;
          softtabstop = 2;
          tabstop = 2;
          number = true;
          relativenumber = true;
          smartindent = true;
          showmatch = true;
          backspace = "indent,eol,start";
        };

        theme.transparent = true;

        extraPlugins = {
          nord-nvim = {
            package = pkgs.vimPlugins.nord-nvim;
          };
          gruvbox-nvim = {
            package = pkgs.vimPlugins.gruvbox-nvim;
          };
          catppuccin-nvim = {
            package = pkgs.vimPlugins.catppuccin-nvim;
          };
        };

        lsp.enable = true;

        syntaxHighlighting = true;
      };
    };
  };
}
