{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./lsp/eslint.nix
    ./lsp/nixd.nix
    ./lsp/oxlint.nix
    ./lsp/ts-ls.nix
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
      biome = {
        enable = true;
        settings = {
          root_markers = [ "biome.json" ];
        };
      };
      cssls.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      marksman.enable = true;
      nushell.enable = true;
      sqls.enable = true;
      statix.enable = true;
      yamlls.enable = true;
      unocss.enable = true;
      vue_ls = {
        enable = true;
        package = pkgs.vue-language-server;
      };
    };
  };

  keymapsOnEvents.LspAttach =
    [
      (lib.mkIf (!config.plugins.conform-nvim.enable) {
        action.__raw = ''vim.lsp.buf.format'';
        mode = "v";
        key = "<leader>lf";
        options = {
          silent = true;
          buffer = false;
          desc = "Format selection";
        };
      })
      # Diagnostic keymaps
      {
        key = "<leader>lH";
        mode = "n";
        action = lib.nixvim.mkRaw "vim.diagnostic.open_float";
        options = {
          silent = true;
          desc = "Lsp diagnostic open_float";
        };
      }
    ]
    ++ lib.optionals
      (
        !config.plugins.fzf-lua.enable
        || (config.plugins.snacks.enable && lib.hasAttr "picker" config.plugins.snacks.settings)
      )
      [
        # Code action keymap (if fzf-lua is not enabled)
        {
          key = "<leader>la";
          mode = "n";
          action = lib.nixvim.mkRaw "vim.lsp.buf.code_action";
          options = {
            silent = true;
            desc = "Lsp buf code_action";
          };
        }
      ];
}
