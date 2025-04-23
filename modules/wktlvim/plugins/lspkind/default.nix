{ config, ... }:
{
  plugins.lspkind = {
    inherit (config.plugins.lsp) enable;
  };
}
