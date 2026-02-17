_: {
  lsp.servers.vue_ls = {
    enable = true;

    # FIXME LSP: inlay_hint col out of range error with multiple LSP clients
    # https://github.com/neovim/neovim/issues/36318

    # config = {
    #   settings = {
    #     vue = {
    #       inlayHints = {
    #         destructuredProps = {
    #           enabled = true;
    #         };
    #         inlineHandlerLoading = {
    #           enabled = true;
    #         };
    #         missingProps = {
    #           enabled = true;
    #         };
    #         optionsWrapper = {
    #           enabled = true;
    #         };
    #         vBindShorthand = {
    #           enabled = true;
    #         };
    #       };
    #     };
    #   };
    # };
  };
}
