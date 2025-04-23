{ config, ... }:
let
  inherit (config) symbol_icons;
in
{
  plugins.which-key = {
    enable = true;

    lazyLoad.settings.event = "DeferredUIEnter";

    settings = {
      spec = [
        {
          __unkeyed-1 = "<leader>f";
          group = "Find";
          icon = symbol_icons.Search;
        }
        {
          __unkeyed-1 = "<leader>l";
          group = "Language Tools";
          icon = symbol_icons.ActiveLSP;
        }
        {
          __unkeyed-1 = "<leader>u";
          group = "UI/UX";
          icon = symbol_icons.Window;
        }
        {
          __unkeyed-1 = "<leader>b";
          group = "Buffers";
          icon = symbol_icons.Tab;
        }
        {
          __unkeyed-1 = "<leader>bs";
          group = "Sort Buffers";
          icon = symbol_icons.Sort;
        }
        {
          __unkeyed-1 = "<leader>d";
          group = "Debugger";
          icon = symbol_icons.Debugger;
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "Git";
          icon = symbol_icons.Git;
        }
        {
          __unkeyed-1 = "<leader>S";
          group = "Session";
          icon = symbol_icons.Session;
        }
        {
          __unkeyed-1 = "<leader>t";
          group = "Terminal";
          icon = symbol_icons.Terminal;
        }
        {
          __unkeyed-1 = "<leader>x";
          group = "Quickfix/Lists";
          icon = symbol_icons.List;
        }
      ];

      replace = {
        desc = [
          [
            "<space>"
            "SPACE"
          ]
          [
            "<leader>"
            "SPACE"
          ]
          [
            "<[cC][rR]>"
            "RETURN"
          ]
          [
            "<[tT][aA][bB]>"
            "TAB"
          ]
          [
            "<[bB][sS]>"
            "BACKSPACE"
          ]
        ];
      };
      win = {
        border = "single";
      };
    };
  };
}
