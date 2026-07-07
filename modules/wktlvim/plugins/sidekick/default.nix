{ config, lib, ... }: {
  plugins = {
    sidekick = {
      enable = true;

      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<leader>ast";
          desc = "Sidekick Toggle";
        }
        {
          __unkeyed-1 = "<leader>asP";
          mode = [
            "n"
            "v"
          ];
          desc = "Ask Prompt";
        }
      ];

      settings = {
        nes = {
          enabled = false;
        };

        mux = {
          backend = "zellij";
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

  keymaps = lib.optionals config.plugins.sidekick.enable [
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
      key = "<leader>asP";
      action.__raw = "function() require('sidekick.cli').prompt() end";
      options.desc = "Ask Prompt";
    }
  ];

  autoCmd = lib.optionals config.plugins.sidekick.enable [
    {
      event = "VimEnter";
      callback.__raw = ''
        function()
          local opts = function(desc)
            return { desc = desc }
          end

          local map = function(mode, key, provider, binary, desc)
            if vim.fn.executable(binary) ~= 1 then
              return
            end

            vim.keymap.set(mode, key, function()
              ${lib.optionalString config.plugins.lz-n.enable "require('lz.n').trigger_load('sidekick.nvim')"}
              require("sidekick.cli").toggle({ name = provider, focus = true })
            end, opts(desc))
          end

          map({ "n", "v" }, "<leader>aso", "opencode", "opencode", "Opencode Toggle")
        end
      '';
    }
  ];
}
