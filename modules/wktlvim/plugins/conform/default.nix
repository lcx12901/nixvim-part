{
  lib,
  config,
  pkgs,
  ...
}:
{
  plugins.conform-nvim = {
    enable = true;

    lazyLoad.settings = {
      cmd = [
        "ConformInfo"
      ];
      event = [ "BufWritePre" ];
    };

    settings = {
      default_format_opts = {
        lsp_format = "fallback";
      };

      format_on_save = # Lua
        ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

             -- Disable autoformat for files in a certain path
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match("/node_modules/") or bufname:match("/.direnv/") then
              return
            end

            return { timeout_ms = 1000, lsp_fallback = true }, on_format
          end
        '';

      formatters_by_ft =
        let
          frontend = {
            __unkeyed-1 = "eslint_d";
            __unkeyed-2 = "biome";
            stop_after_first = true;
          };
        in
        {
          bash = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          nix = [ "nixfmt" ];
          toml = [ "taplo" ];
          yaml = [ "yamlfmt" ];
          sql = [ "sqlfluff" ];
          json = {
            __unkeyed-1 = "eslint_d";
            __unkeyed-2 = "jq";
            stop_after_first = true;
          };
          jsonc = {
            __unkeyed-1 = "eslint_d";
            __unkeyed-2 = "biome";
            __unkeyed-3 = "jq";
            stop_after_first = true;
          };
          typescript = frontend;
          javascript = frontend;
          typescriptreact = frontend;
          vue = frontend;
          css = frontend;
          scss = frontend;
        };

      formatters = {
        stylua.command = lib.getExe pkgs.stylua;
        nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
        biome.command = lib.getExe pkgs.biome;
        eslint_d = {
          command = lib.getExe pkgs.eslint_d;
          cwd.__raw = ''
            require("conform.util").root_file({
              ".eslintrc",
              ".eslintrc.js",
              ".eslintrc.cjs",
              ".eslintrc.yaml",
              ".eslintrc.yml",
              ".eslintrc.json",
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs",
              "eslint.config.ts",
              "eslint.config.mts",
              "eslint.config.cts",
            })
          '';
          require_cwd = true;
        };
        jq.command = lib.getExe pkgs.jq;
        shellcheck.command = lib.getExe pkgs.shellcheck;
        shellharden.command = lib.getExe pkgs.shellharden;
        shfmt.command = lib.getExe pkgs.shfmt;
        sqlfluff.command = lib.getExe pkgs.sqlfluff;
        taplo.command = lib.getExe pkgs.taplo;
        yamlfmt.command = lib.getExe pkgs.yamlfmt;
      };
    };
  };

  keymaps = lib.optionals config.plugins.conform-nvim.enable [
    {
      action.__raw = ''
        function(args)
         vim.cmd({cmd = 'Conform', args = args});
        end
      '';
      mode = "v";
      key = "<leader>lf";
      options = {
        silent = true;
        buffer = false;
        desc = "Format selection";
      };
    }
    {
      action.__raw = ''
        function()
          vim.cmd('Conform');
        end
      '';
      key = "<leader>lf";
      options = {
        silent = true;
        desc = "Format buffer";
      };
    }
  ];

  userCommands = lib.mkIf config.plugins.conform-nvim.enable {
    Conform = {
      desc = "Formatting using conform.nvim";
      range = true;
      command.__raw = ''
        function(args)
          ${lib.optionalString config.plugins.lz-n.enable "require('lz.n').trigger_load('conform.nvim')"}
          local range = nil
          if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
            range = {
              start = { args.line1, 0 },
              ["end"] = { args.line2, end_line:len() },
            }
          end
          require("conform").format({ async = true, lsp_format = "fallback", range = range },
          function(err)
            if not err then
              local mode = vim.api.nvim_get_mode().mode
              if vim.startswith(string.lower(mode), "v") then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
              end
            end
          end)
        end
      '';
    };
  };
}
