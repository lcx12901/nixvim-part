{ lib, config, ... }:
{
  plugins = {
    comment = {
      enable = true;

      settings = {
        opleader = {
          block = "gb";
          line = "gc";
        };

        toggler = {
          block = "gbc";
          line = "gcc";
        };

        extra = {
          above = "gcO";
          below = "gco";
          eol = "gcA";
        };

        pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
      };
    };
  };

  keymaps = lib.mkIf config.plugins.comment.enable [
    {
      mode = "n";
      key = "<Leader>/";
      action.__raw = ''
        function()
          return require("Comment.api").call(
            "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
            "g@$"
          )()
        end
      '';
      options = {
        desc = "Toggle comment line";
        expr = true;
        silent = true;
      };
    }
    {
      mode = "x";
      key = "<Leader>/";
      action = ''"<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>"'';
      options = {
        desc = "Toggle comment";
      };
    }
  ];
}
