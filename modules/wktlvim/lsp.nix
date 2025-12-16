{
  config,
  lib,
  ...
}:
{
  imports = [
    ./lsp/eslint.nix
    ./lsp/harper-ls.nix
    ./lsp/lspconfig.nix
    ./lsp/nil-ls.nix
    ./lsp/ts-ls.nix
    ./lsp/unocss.nix
  ];

  lsp = {
    inlayHints.enable = true;

    servers = {
      "*" = {
        config = {
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
      fish_lsp.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      marksman.enable = true;
      sqls.enable = true;
      statix.enable = true;
      vue_ls.enable = true;
      yamlls.enable = true;
    };
  };

  keymapsOnEvents.LspAttach = [
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
    # Code action keymap
    {
      key = "<leader>la";
      mode = "n";
      action = lib.nixvim.mkRaw "vim.lsp.buf.code_action";
      options = {
        silent = true;
        desc = "Lsp buf code_action";
      };
    }
    {
      key = "<leader>lA";
      mode = "n";
      action = lib.nixvim.mkRaw ''
        function()
          vim.lsp.buf.code_action {
            apply = true,
            context = {
              only = { "source" },
              diagnostics = {},
            }
          }
        end
      '';
      options = {
        silent = true;
        desc = "Lsp source action";
      };
    }
  ]
  ++ lib.optionals (!config.plugins.conform-nvim.enable) [
    {
      key = "<leader>lf";
      mode = "n";
      action = lib.nixvim.mkRaw "vim.lsp.buf.format";
      options = {
        silent = true;
        desc = "Lsp buf format";
      };
    }
  ]
  ++
    lib.optionals
      (
        (
          !config.plugins.snacks.enable
          || (config.plugins.snacks.enable && !lib.hasAttr "picker" config.plugins.snacks.settings)
        )
        && !config.plugins.fzf-lua.enable
      )
      [
        # Definition and type_definition keymaps (conditionally)
        {
          key = "<leader>ld";
          mode = "n";
          action = lib.nixvim.mkRaw "vim.lsp.buf.definition";
          options = {
            silent = true;
            desc = "Lsp buf definition";
          };
        }
        {
          key = "<leader>lt";
          mode = "n";
          action = lib.nixvim.mkRaw "vim.lsp.buf.type_definition";
          options = {
            silent = true;
            desc = "Lsp buf type_definition";
          };
        }
      ];

  plugins = {
    lsp-format.enable = !config.plugins.conform-nvim.enable && config.plugins.lsp.enable;
    lsp-signature.enable = config.plugins.lsp.enable;

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>l";
        group = "LSP";
        icon = " ";
        mode = [
          "n"
          "v"
        ];
      }
      {
        __unkeyed-1 = "<leader>l[";
        desc = "Prev";
      }
      {
        __unkeyed-1 = "<leader>l]";
        desc = "Next";
      }
      {
        __unkeyed-1 = "<leader>la";
        desc = "Code Action";
      }
      {
        __unkeyed-1 = "<leader>lA";
        desc = "Source Action";
      }
      {
        __unkeyed-1 = "<leader>ld";
        desc = "Definition";
      }
      {
        __unkeyed-1 = "<leader>lD";
        desc = "References";
      }
      {
        __unkeyed-1 = "<leader>lf";
        desc = "Format";
      }
      {
        __unkeyed-1 = "<leader>lh";
        desc = "Lsp Hover";
      }
      {
        __unkeyed-1 = "<leader>lH";
        desc = "Diagnostic Hover";
      }
      {
        __unkeyed-1 = "<leader>li";
        desc = "Implementation";
      }
      {
        __unkeyed-1 = "<leader>lr";
        desc = "Rename";
      }
      {
        __unkeyed-1 = "<leader>lt";
        desc = "Type Definition";
      }
    ];
  };
}
