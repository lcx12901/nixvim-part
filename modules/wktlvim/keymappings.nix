{
  helpers,
  lib,
  ...
}:
{
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  keymaps =
    let
      normal =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "n";
              inherit action key;
              options = attrs.options or { };
            }
          )
          {
            "<Space>" = {
              action = "<NOP>";
            };
            # Esc to clear search results
            "<esc>" = {
              action = "<cmd>noh<CR>";
            };
            # Backspace delete in normal
            "<BS>" = {
              action = "<BS>x";
            };
            # Standard Operations
            "j" = {
              action = "v:count == 0 ? 'gj' : 'j'";
              options = {
                desc = "Move cursor down";
                expr = true;
              };
            };
            "k" = {
              action = "v:count == 0 ? 'gk' : 'k'";
              options = {
                desc = "Move cursor up";
                expr = true;
              };
            };
            "<Leader>w" = {
              action = "<Cmd>w<CR>";
              options.desc = "Save";
            };
            "<leader>W" = {
              action = "<Cmd>w!<CR>";
              options.desc = "Force write";
            };
            "<C-S>" = {
              action = "<Cmd>silent! update! | redraw<CR>";
              options.desc = "Force write";
            };
            "<Leader>q" = {
              action = "<Cmd>confirm q<CR>";
              options.desc = "Quit";
            };
            "<leader>Q" = {
              action = "<Cmd>q!<CR>";
              options.desc = "Force quit";
            };
            "|" = {
              action = "<Cmd>vsplit<CR>";
              options.desc = "Vertical Split";
            };
            "\\" = {
              action = "<Cmd>split<CR>";
              options.desc = "Horizontal Split";
            };
            "<Leader>/" = {
              action = "gcc";
              options = {
                desc = "Toggle comment line";
                remap = true;
              };
            };
            # Neovim Default LSP Mappings
            "gco" = {
              action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
              options.desc = "Add Comment Below";
            };
            "gcO" = {
              action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
              options.desc = "Add Comment Above";
            };
            "<Leader>R" = {
              action.__raw = ''function() require("astrocore").rename_file() end'';
              options.desc = "Rename file";
            };
            "gra" = {
              action.__raw = ''function() vim.lsp.buf.code_action() end'';
              options.desc = "vim.lsp.buf.code_action()";
            };
            "grn" = {
              action.__raw = ''function() vim.lsp.buf.rename() end'';
              options.desc = "vim.lsp.buf.rename()";
            };
            "grr" = {
              action.__raw = ''function() vim.lsp.buf.references() end'';
              options.desc = "vim.lsp.buf.references()";
            };
            "gri" = {
              action.__raw = ''function() vim.lsp.buf.implementation() end'';
              options.desc = "vim.lsp.buf.implementation()";
            };
            "gO" = {
              action.__raw = ''function() vim.lsp.buf.document_symbol() end'';
              options.desc = "vim.lsp.buf.document_symbol()";
            };
            # Manage Buffers
            "<Leader>c" = {
              action.__raw = ''function() require("astrocore.buffer").close() end'';
              options.desc = "Close buffer";
            };
            "<Leader>C" = {
              action.__raw = ''function() require("astrocore.buffer").close(0, true) end'';
              options.desc = "Force close buffer";
            };
            "]b" = {
              action.__raw = ''function() require("astrocore.buffer").nav(vim.v.count1) end'';
              options.desc = "Next buffer";
            };
            "[b" = {
              action.__raw = ''function() require("astrocore.buffer").nav(-vim.v.count1) end'';
              options.desc = "Previous buffer";
            };
            ">b" = {
              action.__raw = ''function() require("astrocore.buffer").move(vim.v.count1) end'';
              options.desc = "Move buffer tab right";
            };
            "<b" = {
              action.__raw = ''function() require("astrocore.buffer").move(-vim.v.count1) end'';
              options.desc = "Move buffer tab left";
            };
            "<Leader>bc" = {
              action.__raw = ''function() require("astrocore.buffer").close_all(true) end'';
              options.desc = "Close all buffers except current";
            };
            "<Leader>bC" = {
              action.__raw = ''function() require("astrocore.buffer").close_all() end'';
              options.desc = "Close all buffers";
            };
            "<Leader>bl" = {
              action.__raw = ''function() require("astrocore.buffer").close_left() end'';
              options.desc = "Close all buffers to the left";
            };
            "<Leader>bp" = {
              action.__raw = ''function() require("astrocore.buffer").prev() end'';
              options.desc = "Previous buffer";
            };
            "<Leader>br" = {
              action.__raw = ''function() require("astrocore.buffer").close_right() end'';
              options.desc = "Close all buffers to the right";
            };
            "<Leader>bse" = {
              action.__raw = ''function() require("astrocore.buffer").sort "extension" end'';
              options.desc = "By extension";
            };
            "<Leader>bsr" = {
              action.__raw = ''function() require("astrocore.buffer").sort "unique_path" end'';
              options.desc = "By relative path";
            };
            "<Leader>bsp" = {
              action.__raw = ''function() require("astrocore.buffer").sort "full_path" end'';
              options.desc = "By full path";
            };
            "<Leader>bsi" = {
              action.__raw = ''function() require("astrocore.buffer").sort "bufnr" end'';
              options.desc = "By buffer number";
            };
            "<Leader>bsm" = {
              action.__raw = ''function() require("astrocore.buffer").sort "modified" end'';
              options.desc = "By modification";
            };
            "<Leader>ld" = {
              action.__raw = ''function() vim.diagnostic.open_float() end'';
              options.desc = "Hover diagnostics";
            };
            # Navigate tabs
            "]t" = {
              action.__raw = ''function() vim.cmd.tabnext() end'';
              options.desc = "Next tab";
            };
            "[t" = {
              action.__raw = ''function() vim.cmd.tabprevious() end'';
              options.desc = "Previous tab";
            };
            # Split navigation
            "<C-H>" = {
              action = "<C-w>h";
              options.desc = "Move to left split";
            };
            "<C-J>" = {
              action = "<C-w>j";
              options.desc = "Move to below split";
            };
            "<C-K>" = {
              action = "<C-w>k";
              options.desc = "Move to above split";
            };
            "<C-L>" = {
              action = "<C-w>l";
              options.desc = "Move to right split";
            };
            "<C-Up>" = {
              action = "<Cmd>resize -2<CR>";
              options.desc = "Resize split up";
            };
            "<C-Down>" = {
              action = "<Cmd>resize +2<CR>";
              options.desc = "Resize split down";
            };
            "<C-Left>" = {
              action = "<Cmd>vertical resize -2<CR>";
              options.desc = "Resize split left";
            };
            "<C-Right>" = {
              action = "<Cmd>vertical resize +2<CR>";
              options.desc = "Resize split right";
            };
            # List management
            "<Leader>xq" = {
              action = "<Cmd>copen<CR>";
              options.desc = "Quickfix List";
            };
            "<Leader>xl" = {
              action = "<Cmd>lopen<CR>";
              options.desc = "Location List";
            };
          };
      visual =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "v";
              inherit action key;
              options = attrs.options or { };
            }
          )
          {
            "<S-Tab>" = {
              action = "<gv";
              options.desc = "Unindent line";
            };
            "<Tab>" = {
              action = ">gv";
              options.desc = "Indent line";
            };
            # Backspace delete in visual
            "<BS>" = {
              action = "x";
            };
            # Move selected line/block in visual mode
            "K" = {
              action = "<cmd>m '<-2<CR>gv=gv<cr>";
            };
            "J" = {
              action = "<cmd>m '>+1<CR>gv=gv<cr>";
            };
          };
      insert =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "i";
              inherit action key;
              options = attrs.options or { };
            }
          )
          {
            # Move selected line/block in insert mode
            "<C-k>" = {
              action = "<C-o>gk";
            };
            "<C-h>" = {
              action = "<Left>";
            };
            "<C-l>" = {
              action = "<Right>";
            };
            "<C-j>" = {
              action = "<C-o>gj";
            };
          };
    in
    helpers.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual ++ insert);
}
