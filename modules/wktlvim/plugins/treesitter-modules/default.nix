{ lib, pkgs, ... }:
let
  settings = {
    incremental_selection = {
      enable = true;
      keymaps = {
        init_selection = "<A-o>";
        node_incremental = "<A-o>";
        scope_incremental = "<A-O>";
        node_decremental = "<A-i>";
      };
    };
  };
in
{
  extraPlugins = [
    pkgs.vimPlugins.treesitter-modules-nvim
  ];

  extraConfigLua = ''
    require('treesitter-modules').setup(${lib.generators.toLua { } settings})
  '';
}
