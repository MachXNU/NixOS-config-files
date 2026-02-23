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

        lsp.enable = true;

        syntaxHighlighting = true;
      };
    };
  };
}
