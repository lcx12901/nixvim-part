{
  config,
  lib,
  pkgs,
  ...
}:
{
  extraPlugins = lib.optionals config.plugins.copilot-lua.enable (
    with pkgs.vimPlugins;
    lib.optionals config.plugins.lualine.enable [
      copilot-lualine
    ]
  );

  plugins = {
    copilot-lua = {
      enable = true;

      lazyLoad.settings.event = [ "InsertEnter" ];

      settings = {
        nes = lib.mkIf (!config.plugins.sidekick.enable) {
          enabled = true;
          keymap = {
            accept_and_goto = "<TAB>";
            accept = false;
            dismiss = "<Esc>";
          };
        };

        suggestion = lib.mkIf (!config.plugins.blink-cmp.enable) {
          enabled = true;
          auto_trigger = true;
          keymap = {
            accept = "<C-y>";
            accept_word = "<M-w>";
            accept_line = "<M-e>";
            next = "<M-]>";
            prev = "<M-[>";
            dismiss = "<C-n>";
          };
        };

        panel = lib.mkIf (!config.plugins.blink-cmp.enable) {
          enabled = true;
          auto_refresh = true;
          keymap = {
            jump_prev = "[[";
            jump_next = "]]";
            accept = "<cr>";
            refresh = "gr";
            open = "<M-CR>";
          };
          layout = {
            position = "bottom";
            ratio = 0.4;
          };
        };

        filetypes = {
          yaml = false;
          markdown = false;
          json = false;
          help = false;
          gitcommit = false;
          gitrebase = false;
        };
      };
    };
  };

  autoCmd = lib.mkIf config.plugins.copilot-lua.enable [
    {
      event = "User";
      pattern = "BlinkCmpMenuOpen";
      callback.__raw = ''
        function()
          vim.b.copilot_suggestion_hidden = true
        end
      '';
    }
    {
      event = "User";
      pattern = "BlinkCmpMenuClose";
      callback.__raw = ''
        function()
          vim.b.copilot_suggestion_hidden = false
        end
      '';
    }
  ];
}
