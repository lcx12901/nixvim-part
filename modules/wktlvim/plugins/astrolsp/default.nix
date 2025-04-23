{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    astrolsp
  ];

  extraConfigLuaPre = ''
    vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
  '';
}
