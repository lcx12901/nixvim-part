{ lib, ... }:
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
            # fix Y behaviour
            "Y" = {
              action = "y$";
            };
            # back and fourth between the two most recent files
            "<C-c>" = {
              action = "<cmd>b#<CR>";
            };
            # navigate to left/right window
            "<leader>[" = {
              action = "<C-w>h";
              options = {
                desc = "Left window";
              };
            };
            "<leader>]" = {
              action = "<C-w>l";
              options = {
                desc = "Right window";
              };
            };
            "<leader>." = {
              action = "<C-w>j";
              options = {
                desc = "Up window";
              };
            };
            "<leader>," = {
              action = "<C-w>k";
              options = {
                desc = "Down window";
              };
            };
            # resize with arrows
            "<C-Up>" = {
              action = "<cmd>resize -2<CR>";
            };
            "<C-Down>" = {
              action = "<cmd>resize +2<CR>";
            };
            "<C-Left>" = {
              action = "<cmd>vertical resize +2<CR>";
            };
            "<C-Right>" = {
              action = "<cmd>vertical resize -2<CR>";
            };
            # move current line up/down
            # M = Alt key
            "<M-k>" = {
              action = "<cmd>move-2<CR>";
            };
            "<M-j>" = {
              action = "<cmd>move+<CR>";
            };
            # Action to perform (save the file in this case)
            "<C-s>" = {
              action = "<Cmd>w<CR>";
              options = {
                desc = "Save";
              };
            };

            "<leader>wd" = {
              action = "<C-W>c";
              options = {
                desc = "Delete Window";
              };
            };

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
            "<Leader>q" = {
              action = "<Cmd>confirm q<CR>";
              options = {
                desc = "Quit";
              };
            };
            "|" = {
              action = "<Cmd>vsplit<CR>";
              options = {
                desc = "Vertical split";
              };
            };
            "-" = {
              action = "<Cmd>split<CR>";
              options = {
                desc = "Horizontal split";
              };
            };
            "<S-TAB>" = {
              action = "<cmd>bprevious<CR>";
              options = {
                desc = "Previous buffer";
              };
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
            # Better indenting
            "<S-Tab>" = {
              action = "<gv";
              options = {
                desc = "Unindent line";
              };
            };
            "<" = {
              action = "<gv";
              options = {
                desc = "Unindent line";
              };
            };
            "<Tab>" = {
              action = ">gv";
              options = {
                desc = "Indent line";
              };
            };
            ">" = {
              action = ">gv";
              options = {
                desc = "Indent line";
              };
            };

            # Move selected line/block in visual mode
            "K" = {
              action = "<cmd>m '<-2<CR>gv=gv<cr>";
            };
            "J" = {
              action = "<cmd>m '>+1<CR>gv=gv<cr>";
            };

            # Backspace delete in visual
            "<BS>" = {
              action = "x";
            };
          };
    in
    lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ insert ++ visual);
}
