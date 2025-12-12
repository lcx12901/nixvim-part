{ config, lib, ... }:
{
  plugins.toggleterm = {
    enable = true;

    lazyLoad = {
      settings = {
        cmd = "ToggleTerm";
        keys = [
          "<F7>"
        ];
      };
    };

    settings = {
      direction = "float";
    };
  };

  keymaps = lib.mkIf config.plugins.toggleterm.enable [
    {
      mode = [
        "n"
        "i"
        "t"
      ];
      key = "<F7>";
      action.__raw = ''
        '<Cmd>execute v:count . "ToggleTerm"<CR>'
      '';
      options = {
        desc = "Toggle terminal";
      };
    }
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Switch to normal mode";
    }
  ];
}
