{ config, lib, ... }:
{
  plugins.lualine = {
    enable = true;

    lazyLoad.settings = {
      event = [
        "VimEnter"
        "BufReadPost"
        "BufNewFile"
      ];
      before.__raw = lib.mkIf config.plugins.lz-n.enable ''
        function()
          pcall(vim.cmd, "packadd copilot-lualine")
        end
      '';
    };

    settings = {
      options = {
        component_separators = "";
        section_separators = "";

        disabled_filetypes = {
          __unkeyed-1 = "startify";
          __unkeyed-2 = "neo-tree";
          __unkeyed-3 = "copilot-chat";
          __unkeyed-4 = "ministarter";
          __unkeyed-5 = "Avante";
          __unkeyed-6 = "AvanteInput";
          __unkeyed-7 = "trouble";
          __unkeyed-8 = "dapui_scopes";
          __unkeyed-9 = "dapui_breakpoints";
          __unkeyed-10 = "dapui_stacks";
          __unkeyed-11 = "dapui_watches";
          __unkeyed-12 = "dapui_console";
          __unkeyed-13 = "dashboard";
          __unkeyed-14 = "snacks_dashboard";
          __unkeyed-15 = "AvanteSelectedFiles";
          __unkeyed-16 = "alpha";
          winbar = [
            "aerial"
            "dap-repl"
            "dap-view"
            "dap-view-term"
            "neotest-summary"
            "opencode_terminal"
            "sidekick_terminal"
            "snacks_terminal"
          ];
        };

        globalstatus = true;
      };

      # +-------------------------------------------------+
      # | A | B | C                             X | Y | Z |
      # +-------------------------------------------------+
      sections = {
        lualine_a = [
          {
            __unkeyed-1 = "mode";
            icons_enabled = true;
            icon = "";
            separator = {
              left = "";
              right = "";
            };
          }
        ];
        lualine_b = [
          {
            __unkeyed-1 = "branch";
            icon = "";
            separator = {
              right = "";
            };
          }
        ];
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            symbols = {
              modified = "●";
              alternate_file = "#";
              directory = "";
            };
          }
          {
            __unkeyed-1 = "diff";
            symbols = {
              added = " ";
              modified = " ";
              removed = " ";
            };
          }
        ];

        lualine_x = [
          {
            __unkeyed-1 = "diagnostics";
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
            };
            diagnostics_color = {
              error = {
                fg = "#ed8796";
              };
              warn = {
                fg = "#eed49f";
              };
              info = {
                fg = "#8aadf4";
              };
              hint = {
                fg = "#a6da95";
              };
            };
            colored = true;
          }
          # Show active language server
          (lib.optionalString config.plugins.copilot-lua.enable "copilot")
          {
            __unkeyed-1.__raw = ''
              function()
                  local msg = ""
                  local buf_ft = vim.bo.filetype
                  local clients = vim.lsp.get_clients()
                  if next(clients) == nil then
                      return msg
                  end
                  for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                      end
                  end
                  return msg
              end
            '';
            icon = " ";
            color.fg = "#a9a1e1";
          }
          "filetype"
          "fileformat"
        ];

        lualine_z = [ "location" ];
      };

      tabline = lib.mkIf (!config.plugins.bufferline.enable) {
        lualine_a = [
          {
            __unkeyed-1 = "buffers";
            symbols = {
              alternate_file = "";
            };
          }
        ];
        lualine_z = [ "tabs" ];
      };
    };
  };
}
