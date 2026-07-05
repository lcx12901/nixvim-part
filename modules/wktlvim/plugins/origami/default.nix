{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.nvim-origami ];

  extraConfigLua = ''
    require("origami").setup {}
  '';
}
