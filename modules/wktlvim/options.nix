{
  lib,
  config,
  pkgs,
  ...
}:
{
  clipboard = {
    # Use system clipboard
    register = "unnamedplus";

    providers = {
      wl-copy = {
        enable = true;
        package = pkgs.wl-clipboard;
      };
    };
  };

  # colorscheme = "catppuccin";
  # colorschemes.catppuccin.enable = true;
  luaLoader.enable = true;

  globals = {
    # Disable useless providers
    loaded_ruby_provider = 0; # Ruby
    loaded_perl_provider = 0; # Perl
    loaded_python_provider = 0; # Python 2

    # Custom for toggles
    disable_diagnostics = false;
    disable_autoformat = false;
    spell_enabled = true;
    colorizing_enabled = false;
    first_buffer_opened = false;
    whitespace_character_enabled = false;
  };

  opts = {
    # core
    tabclose = "uselast"; # go to last used tab when closing the current tab
    backspace.__raw = ''vim.list_extend(vim.opt.backspace:get(), { "nostop" })''; # don't stop backspace
    breakindent = true; # wrap indent to match  line start
    cmdheight = 0; # hide command line unless needed
    completeopt = lib.mkIf (!config.plugins.blink-cmp.enable) [
      "menu"
      "menuone"
      "noselect"
      "popup"
    ]; # Options for insert mode completion
    confirm = true; # raise a dialog asking if you wish to save the current file(s)
    copyindent = true; # copy the previous indentation on autoindenting
    cursorline = true; # highlight the text line of the cursor
    diffopt.__raw = ''vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })''; # enable linematch diff algorithm
    fillchars = {
      eob = " ";
    }; # disable `~` on nonexistent lines
    ignorecase = true; # case insensitive searching
    infercase = true; # infer cases in keyword completion
    jumpoptions = { }; # apply no jumpoptions on startup
    laststatus = 3; # global statusline
    linebreak = true; # wrap lines at 'breakat'
    mouse = "a"; # enable mouse support
    number = true; # show numberline
    preserveindent = true; # preserve indent structure as much as possible
    pumheight = 10; # height of the pop up menu
    relativenumber = true; # show relative numberline
    shiftround = true; # round indentation with `>`/`<` to shiftwidth
    shortmess.__raw = ''
      vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { s = true, I = true, c = true, C = true })
    ''; # disable search count wrap, startup messages, and completion messages
    showmode = false; # disable showing modes in command line
    showtabline = 2; # always display tabline
    signcolumn = "yes"; # always show the sign column
    smartcase = true; # case sensitive searching
    splitbelow = true; # splitting a new window below the current one
    splitright = true; # splitting a new window at the right of the current one
    tabstop = 2; # number of space in a tab
    shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
    softtabstop = 0; # If non-zero, number of spaces to insert for a <Tab> (local to buffer)
    expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
    autoindent = true; # Do clever autoindenting
    termguicolors = true; # enable 24-bit RGB color in the TUI
    timeoutlen = 500; # shorten key timeout length a little bit for which-key
    title = true; # set terminal title to the filename and path
    undofile = true; # enable persistent undo
    updatetime = 100; # length of time to wait before triggering the plugin
    virtualedit = "block"; # allow going past end of line in visual block mode
    wrap = false; # disable wrapping of lines longer than the width of window
    writebackup = false; # disable making a backup before overwriting a file
    swapfile = false; # Disable the swap file

    report = 9001; # disable "x more/fewer lines" messages
  };
}
