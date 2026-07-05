{ config, lib, ... }: {
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
          (
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

              # navigate quickfix list
              "]q" = {
                action = "<cmd>cnext<CR>";
                options = {
                  desc = "Next quickfix item";
                };
              };
              "[q" = {
                action = "<cmd>cprev<CR>";
                options = {
                  desc = "Previous quickfix item";
                };
              };

              # "<Leader>w" = {
              #   action = "<Cmd>w<CR>"; # Action to perform (save the file in this case)
              #   options = {
              #     desc = "Save";
              #   };
              # };

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
              "<C-s>" = {
                action = "<Cmd>w<CR>";
                options = {
                  desc = "Save";
                };
              };
              "<Leader>q" = {
                action = "<Cmd>confirm q<CR>";
                options = {
                  desc = "Quit";
                };
              };
              "<C-n>" = {
                action = "<Cmd>enew<CR>";
                options = {
                  desc = "New file";
                };
              };
              "<leader>W" = {
                action = "<Cmd>w!<CR>";
                options = {
                  desc = "Force write";
                };
              };
              "<leader>Q" = {
                action = "<Cmd>q!<CR>";
                options = {
                  desc = "Force quit";
                };
              };

              "<leader>/" = {
                action = "gcc";
                options = {
                  desc = "Toggle comment line";
                  remap = true;
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

              "<leader>b]" = {
                action = "<cmd>bnext<CR>";
                options = {
                  desc = "Next buffer";
                };
              };
              "<TAB>" = {
                action = "<cmd>bnext<CR>";
                options = {
                  desc = "Next buffer (default)";
                };
              };
              "<leader>b[" = {
                action = "<cmd>bprevious<CR>";
                options = {
                  desc = "Previous buffer";
                };
              };
              "<S-TAB>" = {
                action = "<cmd>bprevious<CR>";
                options = {
                  desc = "Previous buffer";
                };
              };
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
            }
            // lib.optionalAttrs (!config.plugins.yanky.enable) {
              "gp" = {
                action = ''"+p'';
                options = {
                  desc = "Paste from system clipboard";
                };
              };
            }
          );

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
          (
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

              "<leader>/" = {
                action = "gc";
                options = {
                  desc = "Toggle comment selection";
                  remap = true;
                };
              };
              "gy" = {
                action = ''"+y'';
                options = {
                  desc = "Copy to system clipboard";
                };
              };
              "<C-s>" = {
                action = "<Esc><Cmd>w<CR>";
                options = {
                  desc = "Save";
                };
              };
            }
            // lib.optionalAttrs (!config.plugins.yanky.enable) {
              "gp" = {
                action = ''"+P'';
                options = {
                  desc = "Paste from system clipboard";
                };
              };
            }
          );

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
            "<C-s>" = {
              action = "<Esc><Cmd>w<CR>";
              options = {
                desc = "Save";
              };
            };
          };
    in
    lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual ++ insert);
}
