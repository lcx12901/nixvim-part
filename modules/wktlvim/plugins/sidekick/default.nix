{
  config,
  lib,
  ...
}:
{
  config = {
    plugins = {
      sidekick = {
        enable = true;

        lazyLoad.settings.keys = [
          {
            __unkeyed-1 = "<leader>ast";
            desc = "Sidekick Toggle";
          }
          {
            __unkeyed-1 = "<leader>asp";
            mode = [
              "n"
              "v"
            ];
            desc = "Ask Prompt";
          }
          {
            __unkeyed-1 = "<leader>asC";
            mode = [
              "n"
              "v"
            ];
            desc = "Copilot Toggle";
          }
        ];

        settings = {
          mux = {
            enabled = true;
          };
        };
      };

      which-key.settings.spec = lib.optionals config.plugins.sidekick.enable [
        {
          __unkeyed-1 = "<leader>as";
          group = "Sidekick";
          icon = "🤖";
          mode = [
            "n"
            "v"
          ];
        }
      ];
    };

    keymaps =
      (lib.optionals (!config.plugins.blink-cmp.enable && config.plugins.sidekick.enable) [
        {
          mode = "n";
          key = "<Tab>";
          action.__raw = ''
            function()
              -- Try sidekick NES first
              if require("sidekick").nes_jump_or_apply() then
                return
              end
              -- fallback to buffer navigation
              vim.cmd('bnext')
            end
          '';
          options = {
            expr = false;
            desc = "Goto/Apply Next Edit Suggestion or Next Buffer";
          };
        }
        {
          mode = "i";
          key = "<Tab>";
          action.__raw = ''
            function()
              -- if there is a next edit, jump to it, otherwise apply it if any
              if not require("sidekick").nes_jump_or_apply() then
                return "<Tab>" -- fallback to normal tab
              end
            end
          '';
          options = {
            expr = true;
            desc = "Goto/Apply Next Edit Suggestion";
          };
        }
      ])
      ++ (lib.optionals (config.plugins.blink-cmp.enable && config.plugins.sidekick.enable) [
        {
          mode = "n";
          key = "<Tab>";
          action.__raw = ''
            function()
              -- Try sidekick NES first
              if require("sidekick").nes_jump_or_apply() then
                return
              end
              -- fallback to buffer navigation
              vim.cmd('bnext')
            end
          '';
          options = {
            expr = false;
            desc = "Goto/Apply Next Edit Suggestion or Next Buffer";
          };
        }
      ])
      ++ [
        {
          mode = "n";
          key = "<leader>ast";
          action.__raw = "function() require('sidekick.cli').toggle({ focus = true }) end";
          options.desc = "Sidekick Toggle";
        }
        {
          mode = [
            "n"
            "v"
          ];
          key = "<leader>asp";
          action.__raw = "function() require('sidekick.cli').select_prompt() end";
          options.desc = "Ask Prompt";
        }
        {
          mode = [
            "n"
            "v"
          ];
          key = "<leader>asc";
          action.__raw = "function() require('sidekick.cli').toggle({ name = 'copilot', focus = true }) end";
          options.desc = "Copilot Toggle";
        }
      ];
  };
}
