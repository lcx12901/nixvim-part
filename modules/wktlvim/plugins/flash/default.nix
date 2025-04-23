{ lib, config, ... }:
{
  plugins = {
    flash = {
      enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";

      settings = {
        modes = {
          char = {
            jump_labels = true;
          };
        };
        search = {
          exclude = [
            "notify"
            "cmp_menu"
            "noice"
            "flash_prompt"
            # "NeogitStatus"
            {
              __raw = ''
                function(win)
                  -- exclude non-focusable windows
                  return not vim.api.nvim_win_get_config(win).focusable
                end
              '';
            }
          ];
        };
      };
    };
  };

  keymaps = lib.mkIf config.plugins.flash.enable [
    {
      mode = "n";
      key = "s";
      action.__raw = ''
        function() require("flash").jump() end
      '';
      options = {
        desc = "Flash jump";
      };
    }
    {
      mode = "n";
      key = "S";
      action.__raw = ''
        function() require("flash").treesitter() end
      '';
      options = {
        desc = "Flash treesitter";
      };
    }
  ];
}
