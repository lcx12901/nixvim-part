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
        function(client, bufnr)
          local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
          if filetype == 'vue' then
            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
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

        preferences = {
          includeInlayParameterNameHints = "all";
          includeInlayParameterNameHintsWhenArgumentMatchesName = true;
          includeInlayFunctionParameterTypeHints = true;
          includeInlayVariableTypeHints = true;
          includeInlayVariableTypeHintsWhenTypeMatchesName = true;
          includeInlayPropertyDeclarationTypeHints = true;
          includeInlayFunctionLikeReturnTypeHints = true;
          includeInlayEnumMemberValueHints = true;
        };
      };
    };
  };
}
