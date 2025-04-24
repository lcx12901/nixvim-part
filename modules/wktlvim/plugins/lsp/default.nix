{
  lib,
  pkgs,
  self,
  config,
  ...
}:
{
  extraConfigLuaPre = ''
    require('lspconfig.ui.windows').default_options = {
      border = "rounded"
    }
  '';

  plugins = {
    # lsp-signature.enable = config.plugins.lsp.enable;

    lsp = {
      enable = true;
      inlayHints = true;

      servers = {
        bashls.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        yamlls.enable = true;
        taplo.enable = true;
        nushell.enable = true;
        statix.enable = true;
        unocss.enable = true;

        nil_ls = {
          enable = !config.plugins.lsp.servers.nixd.enable;
          settings = {
            formatting = {
              command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
            };
            nix = {
              flake = {
                autoArchive = true;
              };
            };
          };
        };

        nixd = {
          enable = false;
          settings =
            let
              flake = ''(builtins.getFlake "${self}")'';
              system = ''''${builtins.currentSystem}'';
            in
            {
              nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
              formatting = {
                command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
              };
              options = {
                nixvim.expr = ''${flake}.packages.${system}.nvim.options'';
              };
            };
        };

        ts_ls = {
          enable = true;
          settings = {
            typescript = {
              tsserver = {
                useSyntaxServer = false;
              };
              inlayHints = {
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

        vtsls = {
          enable = false;
          filetypes = [
            "javascript"
            "javascriptreact"
            "javascript.jsx"
            "typescript"
            "typescriptreact"
            "typescript.tsx"
          ];
          settings =
            let
              inlayHints = {
                parameterNames.enabled = "literals";
                parameterNames.suppressWhenArgumentMatchesName = true;
                parameterTypes.enabled = true;
                variableTypes.enabled = true;
                variableTypes.suppressWhenTypeMatchesName = true;
                propertyDeclarationTypes.enabled = true;
                functionLikeReturnTypes.enabled = true;
                enumMemberValues.enabled = true;
              };
            in
            {
              typescipt = {
                inherit inlayHints;

                globalTsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";
                locale = "zh-CN";
                updateImportsOnFileMove.enabled = "always";
              };

              vtsls.tsserver.globalPlugins = [
                {
                  name = "@vue/typescript-plugin";
                  location = "${lib.getBin pkgs.vue-language-server}/lib/node_modules/@vue/language-server";
                  languages = [ "vue" ];
                  configNamespace = "typescipt";
                  enableForWorkspaceTypeScriptVersions = true;
                }
              ];
            };
        };

        volar = {
          enable = true;
          extraOptions = {
            init_options = {
              vue = {
                hybridMode = true;
              };
              typescript = {
                tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";
              };
            };
          };
          onAttach.function = ''
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          '';
        };

        eslint = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
            "typescript.tsx"
            "vue"
            "astro"
            "svelte"
            "html"
            "json"
            "jsonc"
            "css"
            "scss"
          ];
          extraOptions = {
            rulesCustomizations = [
              {
                rule = "style/*";
                severity = "off";
                fixable = true;
              }
              {
                rule = "format/*";
                severity = "off";
                fixable = true;
              }
              {
                rule = "*-indent";
                severity = "off";
                fixable = true;
              }
              {
                rule = "*-spacing";
                severity = "off";
                fixable = true;
              }
              {
                rule = "*-spaces";
                severity = "off";
                fixable = true;
              }
              {
                rule = "*-order";
                severity = "off";
                fixable = true;
              }
              {
                rule = "*-dangle";
                severity = "off";
                fixable = true;
              }
              {
                rule = "*-newline";
                severity = "off";
                fixable = true;
              }
              {
                rule = "*quotes";
                severity = "off";
                fixable = true;
              }
              {
                rule = "*semi";
                severity = "off";
                fixable = true;
              }
            ];
          };
          onAttach.function = ''
            vim.api.nvim_create_autocmd("BufWritePre", {buffer = bufnr,command = "EslintFixAll",})
          '';
        };
      };
    };
  };
}
