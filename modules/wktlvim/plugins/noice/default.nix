{ config, lib, ... }: {
  plugins = {
    noice = {
      enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";

      settings = {
        # Hides the title above noice boxes
        cmdline = {
          enabled = true;
          format = {
            cmdline = {
              pattern = "^:";
              icon = "";
              lang = "vim";
              opts = {
                border = {
                  text = {
                    top = "Cmd";
                  };
                };
              };
            };
            search_down = {
              kind = "search";
              pattern = "^/";
              icon = " ";
              lang = "regex";
            };
            search_up = {
              kind = "search";
              pattern = "^%?";
              icon = " ";
              lang = "regex";
            };
            filter = {
              pattern = "^:%s*!";
              icon = "";
              lang = "bash";
              opts = {
                border = {
                  text = {
                    top = "Bash";
                  };
                };
              };
            };
            lua = {
              pattern = "^:%s*lua%s+";
              icon = "";
              lang = "lua";
            };
            help = {
              pattern = "^:%s*he?l?p?%s+";
              icon = "󰋖";
            };
            input = { };
          };
        };

        messages = {
          view = "notify";
          view_error = "notify";
          view_warn = "notify";
        };

        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };

          progress.enabled = false;
          signature.enabled = false;
          hover.enabled = false;
        };

        presets = {
          bottom_search = false;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
          lsp_doc_border = true;
        };

        routes = [
          # Skip search_count messages
          {
            filter = {
              event = "msg_show";
              kind = "search_count";
            };
            opts = {
              skip = true;
            };
          }
          # Skip annoying "written" messages
          {
            filter = {
              event = "msg_show";
              find = "written";
            };
            opts = {
              skip = true;
            };
          }
          # Skip "search hit BOTTOM/TOP" messages
          {
            filter = {
              event = "msg_show";
              any = [
                { find = "search hit BOTTOM"; }
                { find = "search hit TOP"; }
              ];
            };
            opts = {
              skip = true;
            };
          }
          # Skip "Pattern not found" messages
          {
            filter = {
              event = "msg_show";
              find = "Pattern not found";
            };
            opts = {
              skip = true;
            };
          }
          {
            filter = {
              event = "notify";
              any = [
                { find = "No information available"; }
                { find = "No signature help available"; }
                { find = "Empty hover response"; }
              ];
            };
            opts = {
              skip = true;
            };
          }
        ];
      };
    };

    notify = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
  };

  keymaps =
    lib.optionals config.plugins.noice.enable [
      {
        mode = "n";
        key = "<leader>fn";
        action = if config.plugins.snacks.enable then "<cmd>Noice snacks<CR>" else "<cmd>Noice<CR>"; # Fallback to basic Noice command
        options = {
          desc = "Find notifications";
        };
      }
    ]
    ++ lib.optionals config.plugins.noice.enable [
      {
        mode = "c";
        key = "<S-Enter>";
        action.__raw = ''
          function()
            require("noice").redirect(vim.fn.getcmdline())
          end
        '';
        options = {
          desc = "Redirect Cmdline to Popup";
        };
      }
    ];
}
