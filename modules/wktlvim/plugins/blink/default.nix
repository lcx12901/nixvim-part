{
  lib,
  config,
  pkgs,
  ...
}:
{
  extraPackages = lib.mkIf config.plugins.blink-cmp.enable (
    with pkgs;
    [
      # blink-cmp-git
      gh
      # blink-cmp-dictionary
      wordnet
    ]
  );

  extraPlugins = with pkgs.vimPlugins; [
    blink-cmp-avante
    blink-cmp-conventional-commits
    blink-nerdfont-nvim
  ];

  plugins = lib.mkMerge [
    {
      blink-cmp = {
        enable = true;

        lazyLoad.settings.event = [
          "InsertEnter"
          "CmdlineEnter"
        ];

        settings = {
          cmdline = {
            completion = {
              ghost_text.enabled = false;
            };
          };

          fuzzy.implementation = "prefer_rust";

          completion = {
            list = {
              selection = {
                preselect = false;
                auto_insert = true;
              };
            };
            menu = {
              auto_show.__raw = ''function(ctx) return ctx.mode ~= "cmdline" end'';
              border = "rounded";
              winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None";
              draw = {
                treesitter = [ "lsp" ];
                columns = [
                  {
                    __unkeyed-1 = "label";
                  }
                  {
                    __unkeyed-1 = "kind_icon";
                    __unkeyed-2 = "kind";
                    gap = 1;
                  }
                  { __unkeyed-1 = "source_name"; }
                ];
                components = {
                  kind_icon = {
                    text.__raw = ''function(ctx) return get_kind_icon(ctx).text end'';
                    highlight.__raw = ''function(ctx) return get_kind_icon(ctx).highlight end'';
                  };
                };
              };
            };
            accept = {
              auto_brackets.enabled = true;
            };
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 0;
              window = {
                border = "rounded";
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None";
              };
            };
          };

          signature = {
            window = {
              border = "rounded";
              winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder";
            };
          };

          snippets.preset = "mini_snippets";

          appearance = {
            use_nvim_cmp_as_default = true;
            kind_icons = {
              Copilot = "";
            };
          };

          sources = {
            default.__raw = ''
              function(ctx)
                -- Base sources that are always available
                local base_sources = { 'buffer', 'lsp', 'path', 'snippets' }

                -- Build common sources list dynamically based on enabled plugins
                local common_sources = vim.deepcopy(base_sources)

                -- Add optional sources based on plugin availability
                ${lib.optionalString config.plugins.copilot-lua.enable "table.insert(common_sources, 'copilot')"}
                ${lib.optionalString config.plugins.blink-cmp-dictionary.enable "table.insert(common_sources, 'dictionary')"}
                ${lib.optionalString config.plugins.blink-emoji.enable "table.insert(common_sources, 'emoji')"}
                ${lib.optionalString (lib.elem pkgs.vimPlugins.blink-nerdfont-nvim config.extraPlugins) "table.insert(common_sources, 'nerdfont')"}
                ${lib.optionalString config.plugins.blink-cmp-spell.enable "table.insert(common_sources, 'spell')"}
                ${lib.optionalString config.plugins.blink-ripgrep.enable "table.insert(common_sources, 'ripgrep')"}

                -- Special context handling
                local success, node = pcall(vim.treesitter.get_node)
                if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                  return { 'buffer', 'spell', 'dictionary' }
                elseif vim.bo.filetype == 'gitcommit' then
                  local git_sources = { 'buffer', 'spell', 'dictionary' }
                  ${lib.optionalString config.plugins.blink-cmp-git.enable "table.insert(git_sources, 'git')"}
                  return git_sources
                ${lib.optionalString config.plugins.avante.enable # Lua
                  ''
                    elseif vim.bo.filetype == 'AvanteInput' then
                      return { 'buffer', 'avante' }
                  ''
                }
                else
                  return common_sources
                end
              end
            '';
            providers = {
              # BUILT-IN SOURCES
              lsp.score_offset = 4;
              # Community sources
              copilot = lib.mkIf config.plugins.copilot-lua.enable {
                name = "copilot";
                module = "blink-copilot";
                async = true;
                score_offset = 100;
              };
              dictionary = lib.mkIf config.plugins.blink-cmp-dictionary.enable {
                name = "Dict";
                module = "blink-cmp-dictionary";
                min_keyword_length = 3;
              };
              emoji = lib.mkIf config.plugins.blink-emoji.enable {
                name = "Emoji";
                module = "blink-emoji";
                score_offset = 1;
              };
              git = lib.mkIf config.plugins.blink-cmp-git.enable {
                name = "Git";
                module = "blink-cmp-git";
                enabled = true;
                score_offset = 100;
                should_show_items.__raw = ''
                  function()
                    return vim.o.filetype == 'gitcommit' or vim.o.filetype == 'markdown'
                  end
                '';
                opts = {
                  git_centers = {
                    github = {
                      issue = {
                        on_error.__raw = "function(_,_) return true end";
                      };
                    };
                  };
                };
              };
              ripgrep = lib.mkIf config.plugins.blink-ripgrep.enable {
                name = "Ripgrep";
                module = "blink-ripgrep";
                async = true;
                score_offset = 1;
              };
              spell = lib.mkIf config.plugins.blink-cmp-spell.enable {
                name = "Spell";
                module = "blink-cmp-spell";
                score_offset = 1;
              };
              nerdfont = lib.mkIf (lib.elem pkgs.vimPlugins.blink-nerdfont-nvim config.extraPlugins) {
                module = "blink-nerdfont";
                name = "Nerd Fonts";
                score_offset = 15;
                opts = {
                  insert = true;
                };
              };
            };
          };

          keymap = {
            "<A-Space>" = [
              "show"
              "show_documentation"
              "hide_documentation"
            ];
            "<Up>" = [
              "select_prev"
              "fallback"
            ];
            "<Down>" = [
              "select_next"
              "fallback"
            ];
            "<C-N>" = [
              "select_next"
              "show"
            ];
            "<C-P>" = [
              "select_prev"
              "show"
            ];
            "<C-J>" = [
              "select_next"
              "fallback"
            ];
            "<C-K>" = [
              "select_prev"
              "fallback"
            ];
            "<C-U>" = [
              "scroll_documentation_up"
              "fallback"
            ];
            "<C-D>" = [
              "scroll_documentation_down"
              "fallback"
            ];
            "<C-e>" = [
              "hide"
              "fallback"
            ];
            "<CR>" = [
              "accept"
              "fallback"
            ];
            "<Tab>" = [
              "select_next"
              "snippet_forward"
              {
                __raw = ''
                  function(cmp)
                    if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
                  end
                '';
              }
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "snippet_backward"
              {
                __raw = ''
                  function(cmp)
                    if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
                  end
                '';
              }
              "fallback"
            ];
          };
        };

        luaConfig.pre = ''
          local function has_words_before()
            local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
          end

          ---@type function?, function?
          local icon_provider, hl_provider

          local function get_kind_icon(CTX)
            -- Evaluate icon provider
            if not icon_provider then
              local _, mini_icons = pcall(require, "mini.icons")
              if _G.MiniIcons then
                icon_provider = function(ctx)
                  local is_specific_color = ctx.kind_hl and ctx.kind_hl:match "^HexColor" ~= nil
                  if ctx.item.source_name == "LSP" then
                    local icon, hl = mini_icons.get("lsp", ctx.kind or "")
                    if icon then
                      ctx.kind_icon = icon
                      if not is_specific_color then ctx.kind_hl = hl end
                    end
                  elseif ctx.item.source_name == "Path" then
                    ctx.kind_icon, ctx.kind_hl = mini_icons.get(ctx.kind == "Folder" and "directory" or "file", ctx.label)
                  elseif ctx.item.source_name == "Snippets" then
                    ctx.kind_icon, ctx.kind_hl = mini_icons.get("lsp", "snippet")
                  end
                end
              end
              if not icon_provider then
                local lspkind_avail, lspkind = pcall(require, "lspkind")
                if lspkind_avail then
                  icon_provider = function(ctx)
                    if ctx.item.source_name == "LSP" then
                      local icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
                      if icon then ctx.kind_icon = icon end
                    elseif ctx.item.source_name == "Snippets" then
                      local icon = lspkind.symbolic("snippet", { mode = "symbol" })
                      if icon then ctx.kind_icon = icon end
                    end
                  end
                end
              end
              if not icon_provider then icon_provider = function() end end
            end
            -- Evaluate highlight provider
            if not hl_provider then
              local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
              if highlight_colors_avail then
                local kinds
                hl_provider = function(ctx)
                  if not kinds then kinds = require("blink.cmp.types").CompletionItemKind end
                  if ctx.item.kind == kinds.Color then
                    local doc = vim.tbl_get(ctx, "item", "documentation")
                    if doc then
                      local color_item = highlight_colors_avail and highlight_colors.format(doc, { kind = kinds[kinds.Color] })
                      if color_item and color_item.abbr_hl_group then
                        if color_item.abbr then ctx.kind_icon = color_item.abbr end
                        ctx.kind_hl = color_item.abbr_hl_group
                      end
                    end
                  end
                end
              end
              if not hl_provider then hl_provider = function() end end
            end
            -- Call resolved providers
            icon_provider(CTX)
            hl_provider(CTX)
            -- Return text and highlight information
            return { text = CTX.kind_icon .. CTX.icon_gap, highlight = CTX.kind_hl }
          end
        '';
      };
      blink-cmp-dictionary.enable = true;
      blink-cmp-git.enable = true;
      blink-cmp-spell.enable = true;
      blink-emoji.enable = true;
      blink-copilot.enable = true;
      blink-ripgrep.enable = true;
    }
  ];
}
