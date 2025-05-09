{
  imports = [
    ./lsp/eslint.nix
    ./lsp/nixd.nix
    ./lsp/ts-ls.nix
    ./lsp/volar.nix
  ];

  lsp = {
    inlayHints.enable = true;

    servers = {
      "*" = {
        settings = {
          capabilities = {
            textDocument = {
              semanticTokens = {
                multilineTokenSupport = true;
              };
            };
          };
          root_markers = [
            ".git"
          ];
        };
      };

      bashls.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      marksman.enable = true;
      nushell.enable = true;
      sqls.enable = true;
      statix.enable = true;
      yamlls.enable = true;
      unocss.enable = true;
    };
  };
}
