{
  autoCmd = [
    # This autocommand sets the code to be more readable
    {
      event = "BufEnter";
      once = true;
      callback = {
        __raw = ''
          function ()
            vim.cmd("highlight Comment cterm=italic gui=italic")
            vim.cmd("highlight Keyword cterm=italic gui=italic")
            vim.cmd("highlight Identifier cterm=italic gui=italic")
            vim.cmd("highlight Type cterm=italic gui=italic")
            vim.cmd("highlight Statement cterm=italic gui=italic")
            vim.cmd("highlight Conditional cterm=italic gui=italic")
            vim.cmd("highlight Repeat cterm=italic gui=italic")
            vim.cmd("highlight Operator cterm=italic gui=italic")
            vim.cmd("highlight Function cterm=italic gui=italic")
            vim.cmd("highlight Constant cterm=italic gui=italic")
            vim.cmd("highlight String cterm=italic gui=italic")
            vim.cmd("highlight Number cterm=italic gui=italic")
            vim.cmd("highlight Boolean cterm=italic gui=italic")
            vim.cmd("highlight Float cterm=italic gui=italic")
            vim.cmd("highlight @keyword cterm=italic gui=italic")
            vim.cmd("highlight @conditional cterm=italic gui=italic")
            vim.cmd("highlight @repeat cterm=italic gui=italic")
            vim.cmd("highlight @operator cterm=italic gui=italic")
            vim.cmd("highlight @function cterm=italic gui=italic")
            vim.cmd("highlight @constant cterm=italic gui=italic")
            vim.cmd("highlight @string cterm=italic gui=italic")
            vim.cmd("highlight @number cterm=italic gui=italic")
            vim.cmd("highlight @boolean cterm=italic gui=italic")
            vim.cmd("highlight @float cterm=italic gui=italic")
            vim.cmd("highlight NonText cterm=italic gui=italic")
            vim.cmd("highlight DiagnosticVirtualTextError cterm=italic gui=italic")
            vim.cmd("highlight DiagnosticVirtualTextWarn cterm=italic gui=italic")
            vim.cmd("highlight DiagnosticVirtualTextInfo cterm=italic gui=italic")
            vim.cmd("highlight DiagnosticVirtualTextHint cterm=italic gui=italic")
            vim.cmd("highlight LspCodeLens cterm=italic gui=italic")
            vim.cmd("highlight LspInlayHint cterm=italic gui=italic")
            vim.cmd("highlight GitSignsAddInline cterm=italic gui=italic")
            vim.cmd("highlight GitSignsChangeInline cterm=italic gui=italic")
            vim.cmd("highlight GitSignsDeleteInline cterm=italic gui=italic")

            vim.api.nvim_set_hl(0, "nixInvalidSimpleStringEscape", { link = "Normal" })
          end
        '';
      };
    }
  ];
}
