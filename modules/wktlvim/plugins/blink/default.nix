{ config, lib, ... }: {
  imports = [
    ./community-plugins.nix
    ./packages.nix
    ./sources.nix
  ];

  plugins.blink-cmp = {
    enable = true;

    lazyLoad.settings.event = [
      "InsertEnter"
      "CmdlineEnter"
    ];

    settings = {
      # NvChad 默认 appearance
      appearance = {
        nerd_font_variant = "normal";
      };

      cmdline = {
        completion = {
          list.selection = {
            preselect = false;
          };
          menu.auto_show = true;
        };
        keymap = {
          preset = "enter";
          "<CR>" = [
            "accept_and_enter"
            "fallback"
          ];
        };
      };

      completion = {
        keyword = {
          range = "full";
        };

        trigger = {
          prefetch_on_insert = true;
          show_on_backspace = true;
        };

        ghost_text.enabled = true;

        accept.auto_brackets = {
          override_brackets_for_filetypes = {
            lua = [
              "{"
              "}"
            ];
            nix = [
              "{"
              "}"
            ];
          };
        };

        documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
          window.border = "rounded";
        };

        list.selection = {
          auto_insert = false;
          preselect = false;
        };

        menu = {
          border = "rounded";
          direction_priority.__raw = ''
            function()
              local ctx = require('blink.cmp').get_context()
              local item = require('blink.cmp').get_selected_item()
              if ctx == nil or item == nil then return { 's', 'n' } end

              local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
              local is_multi_line = item_text:find('\n') ~= nil

              -- after showing the menu upwards, we want to maintain that direction
              -- until we re-open the menu, so store the context id in a global variable
              if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
                vim.g.blink_cmp_upwards_ctx_id = ctx.id
                return { 'n', 's' }
              end
              return { 's', 'n' }
            end
          '';
          draw = {
            padding = [
              1
              1
            ];
            columns.__raw = ''
              { { "label" }, { "kind_icon" }, { "kind" } }
            '';
            components = {
              kind_icon = {
                text.__raw = ''
                  function(ctx)
                    local icons = require("nvchad.icons.lspkind")
                    return (icons[ctx.kind] or "󰈚")
                  end
                '';
              };
            };
          };
        };
      };

      fuzzy = {
        implementation = "rust";
        sorts = [
          "exact"
          "score"
          "sort_text"
        ];
        prebuilt_binaries = {
          download = false;
        };
      };

      keymap = {
        preset = "enter";
        "<C-.>" = [
          "show"
          "show_documentation"
          "hide_documentation"
        ];
        "<A-1>" = [ { __raw = "function(cmp) cmp.accept({ index = 1 }) end"; } ];
        "<A-2>" = [ { __raw = "function(cmp) cmp.accept({ index = 2 }) end"; } ];
        "<A-3>" = [ { __raw = "function(cmp) cmp.accept({ index = 3 }) end"; } ];
        "<A-4>" = [ { __raw = "function(cmp) cmp.accept({ index = 4 }) end"; } ];
        "<A-5>" = [ { __raw = "function(cmp) cmp.accept({ index = 5 }) end"; } ];
        "<A-6>" = [ { __raw = "function(cmp) cmp.accept({ index = 6 }) end"; } ];
        "<A-7>" = [ { __raw = "function(cmp) cmp.accept({ index = 7 }) end"; } ];
        "<A-8>" = [ { __raw = "function(cmp) cmp.accept({ index = 8 }) end"; } ];
        "<A-9>" = [ { __raw = "function(cmp) cmp.accept({ index = 9 }) end"; } ];
        "<A-0>" = [ { __raw = "function(cmp) cmp.accept({ index = 10 }) end"; } ];
        "<C-y>" =
          lib.optionals config.plugins.sidekick.enable [
            {
              __raw = ''
                function()
                  return require("sidekick").nes_jump_or_apply()
                end
              '';
            }
          ]
          ++ [ "fallback" ];
      };

      signature = {
        enabled = true;
        window.border = "rounded";
      };

      snippets.preset = "luasnip";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>uca";
      action.__raw = ''
        function()
          -- vim.b.completion is nil by default (enabled), false = disabled
          if vim.b.completion == false then
            vim.b.completion = true
            vim.notify("Completion On", "info")
          else
            vim.b.completion = false
            vim.notify("Completion Off", "info")
          end
        end
      '';
      options.desc = "Toggle Completions (Buffer)";
    }
    {
      mode = "n";
      key = "<leader>uci";
      action.__raw = ''
        function()
          vim.g.blink_show_item_idx = not vim.g.blink_show_item_idx
          vim.notify(string.format("Completion Item Index %s", bool2str(vim.g.blink_show_item_idx), "info"))
        end
      '';
      options.desc = "Completion Item Index toggle";
    }
    {
      mode = "n";
      key = "<leader>ucp";
      action.__raw = ''
        function()
          vim.g.blink_path_from_cwd = not vim.g.blink_path_from_cwd
          vim.notify(string.format("Path Completion from CWD %s", bool2str(vim.g.blink_path_from_cwd), "info"))
        end
      '';
      options.desc = "Path Completion from CWD toggle";
    }
    {
      mode = "n";
      key = "<leader>ucb";
      action.__raw = ''
        function()
          vim.g.blink_buffer_all_buffers = not vim.g.blink_buffer_all_buffers
          vim.notify(string.format("Buffer Completion from All Buffers %s", bool2str(vim.g.blink_buffer_all_buffers), "info"))
        end
      '';
      options.desc = "Buffer Completion from All Buffers toggle";
    }
  ];
}
