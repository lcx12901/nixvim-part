{ lib, pkgs, ... }:
{
  lsp.servers.ts_ls = {
    enable = true;

    settings = {
      filetypes = [
        "typescript"
        "javascript"
        "javascriptreact"
        "typescriptreact"
        "vue"
      ];

      init_options = {
        plugins = [
          {
            name = "@vue/typescript-plugin";
            location = "${lib.getBin pkgs.vue-language-server}/lib/node_modules/@vue/language-server";
            languages = [ "vue" ];
          }
        ];
      };

      typescript = {
        tsserver = {
          maxTsServerMemory = 16184;
        };
      };

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
}
