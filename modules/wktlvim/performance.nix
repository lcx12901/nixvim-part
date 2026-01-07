{ pkgs, ... }:
{
  performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      luaLib = true;
      nvimRuntime = true;
      plugins = true;
    };

    combinePlugins = {
      standalonePlugins = with pkgs.vimPlugins; [
        "nvim-treesitter"
        mini-nvim
        "friendly-snippets" # needed for blink to access friendly-snippets
      ];
    };
  };
}
