{ config, lib, ... }:
{
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

        list = {
          max_items = 20;
          selection = {
            auto_insert = false;
            preselect = false;
          };
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
            snippet_indicator = "◦";
            treesitter = [ "lsp" ];
            columns.__raw = ''
              function()
                if vim.g.blink_show_item_idx == nil then vim.g.blink_show_item_idx = true end

                if vim.g.blink_show_item_idx then
                  return {
                    { "item_idx" },
                    { "label" },
                    { "kind_icon", "kind", gap = 1 },
                    { "source_name", gap = 1 }
                  }
                else
                  return {
                    { "label" },
                    { "kind_icon", "kind", gap = 1 },
                    { "source_name", gap = 1 }
                  }
                end
              end
            '';
            components = {
              item_idx = {
                text.__raw = ''
                  function(ctx)
                    return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx)
                  end
                '';
                highlight = "BlinkCmpItemIdx";
              };
              kind_icon = {
                ellipsis = false;
                text.__raw = ''
                  function(ctx)
                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                    -- Check for both nil and the default fallback icon
                    if not kind_icon or kind_icon == '󰞋' then
                      -- Use our configured kind_icons
                      return require('blink.cmp.config').appearance.kind_icons[ctx.kind] or ""
                    end
                    return kind_icon
                  end,
                  -- Optionally, you may also use the highlights from mini.icons
                  highlight = function(ctx)
                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    return hl
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

      appearance = {
        kind_icons = {
          Copilot = "";

          Text = "";
          Field = "";
          Variable = "";

          Class = "";
          Interface = "";

          TypeParameter = "";
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

      snippets.preset = "mini_snippets";
    };
  };
}
