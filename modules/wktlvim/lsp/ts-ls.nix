{ lib, pkgs, ... }:
{
  lsp.servers.ts_ls = {
    enable = true;

    config = {
      filetypes = [
        "typescript"
        "javascript"
        "javascriptreact"
        "typescriptreact"
        "vue"
      ];

      on_attach.__raw = ''
        function(client)
          local existing_capabilities = client.server_capabilities
          if vim.bo.filetype == 'vue' then
            existing_capabilities.semanticTokensProvider.full = false
          else
            existing_capabilities.semanticTokensProvider.full = true
          end
        end
      '';

      init_options = {
        plugins = [
          {
            name = "@vue/typescript-plugin";
            location = "${lib.getBin pkgs.vue-language-server}/lib/language-tools/packages/language-server";
            languages = [ "vue" ];
          }
        ];

        maxTsServerMemory = 16184;

        # preferences = {
        #   includeInlayParameterNameHints = "all";
        #   includeInlayParameterNameHintsWhenArgumentMatchesName = false;
        #   includeInlayFunctionParameterTypeHints = true;
        #   includeInlayVariableTypeHints = true;
        #   includeInlayVariableTypeHintsWhenTypeMatchesName = false;
        #   includeInlayPropertyDeclarationTypeHints = true;
        #   includeInlayFunctionLikeReturnTypeHints = true;
        #   includeInlayEnumMemberValueHints = true;
        # };
      };
    };
  };
}
