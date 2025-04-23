{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) symbol_icons text_icons;

  attributes = import ./status/attributes.nix;
  colors = import ./status/colors.nix;
  icon_highlights = import ./status/icon-highlights.nix;
  modes = import ./status/modes.nix;
  separators = import ./status/separators.nix;
  sign_handlers = import ./status/signs.nix;

  status = {
    inherit
      attributes
      icon_highlights
      modes
      separators
      sign_handlers
      ;

    fallback_colors = colors.fallback;
    setup_colors = colors.setup;
  };
in
{
  extraPlugins = with pkgs.vimPlugins; [
    astroui
    astrolsp
  ];

  extraConfigLuaPre = ''
    require('astroui').setup {
      folding = {
        enabled = function(bufnr) return require("astrocore.buffer").is_valid(bufnr) end,
        methods = { "lsp", "treesitter", "indent" },
      },
      status = ${lib.nixvim.toLuaObject status},
      icons = ${lib.nixvim.toLuaObject symbol_icons},
      text_icons = ${lib.nixvim.toLuaObject text_icons},
    }
  '';
}
