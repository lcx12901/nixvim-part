{ lib, pkgs, ... }:
{
  lsp = {
    inlayHints.enable = true;

    servers = {
      # Languages
      bashls.enable = true;
      eslint = {
        enable = true;
        config = {
          settings = {
            format = false;
            nodePath = "${pkgs.eslint}/lib/node_modules";
          };
        };
      };
      emmylua_ls.enable = true;
      jsonls.enable = true;
      marksman.enable = true;
      sqls.enable = true;
      yamlls.enable = true;
      nixd = {
        enable = true;
        config.settings.nixd = {
          formatting = {
            command = [ "${lib.getExe pkgs.nixfmt}" ];
          };
        };
      };
      ts_ls = {
        enable = true;
        config = {
          filetypes = [
            "typescript"
            "typescriptreact"
            "javascript"
            "javascriptreact"
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

            maxTsServerMemory = 16384;
          };
        };
      };
      vue_ls.enable = true;
      unocss = {
        enable = true;
        package = pkgs.unocss-language-server;
      };
    };
  };
}
