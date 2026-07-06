{
  lib,
  pkgs,
  ...
}:
let
  chadrc = {
    ui = {
      statusline = {
        enabled = true;
        theme = "minimal"; # default, vscode, vscode_colored, minimal
        separator_style = "round";
      };
      tabufline = {
        enabled = true;
        lazyload = false;
        order = [
          "buffers"
          "tabs"
        ];
      };
    };
    base46 = {
      theme = "catppuccin"; # 默认主题
      transparency = false;
      # 添加 navic 集成
      integrations = [
        "navic"
        "blink"
      ];
      hl_override = {
        # 传统高亮组
        "Comment" = {
          italic = true;
        };
        "Constant" = {
          italic = true;
        };
        "String" = {
          italic = true;
        };
        "Keyword" = {
          italic = true;
        };
        "Function" = {
          italic = true;
        };
        "Type" = {
          italic = true;
        };
        # Treesitter 高亮组
        "@comment" = {
          italic = true;
        };
        "@constant" = {
          italic = true;
        };
        "@string" = {
          italic = true;
        };
        "@keyword" = {
          italic = true;
        };
        "@function" = {
          italic = true;
        };
        "@type" = {
          italic = true;
        };
      };
    };

    colorify = {
      enabled = true;
      mode = "virtual"; # fg, bg, virtual
      virt_text = "󱓻 ";
      highlight = {
        hex = true;
        lspvars = true;
      };
    };
  };

  # 构建合成的 chadrc 插件
  chadrc-plugin = pkgs.vimUtils.buildVimPlugin {
    name = "chadrc";
    src = pkgs.writeTextFile {
      name = "chadrc.lua";
      text = ''
        local M = ${lib.generators.toLua { } chadrc}
        return M
      '';
      destination = "/lua/chadrc.lua";
    };
  };

  # 构建 base46 缓存
  base46-cache = pkgs.callPackage ../../../../pkgs/base46-cache.nix {
    inherit chadrc;
  };
in
{
  # 添加 nvchad-ui 及其依赖
  extraPlugins = with pkgs.vimPlugins; [
    plenary-nvim # nvchad-ui 依赖
    nvim-web-devicons # nvchad-ui 需要的图标插件
    (nvchad-ui.overrideAttrs (_: {
      doCheck = false;
    })) # 跳过 require check
    chadrc-plugin # 合成的 chadrc
  ];

  # 禁用冲突的内置插件 + 设置 base46 缓存
  extraConfigLuaPre = lib.mkBefore ''
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwSettings = 1
    vim.g.loaded_netrwFileHandlers = 1
    vim.g.loaded_netrw_gitignore = 1

    -- 设置 base46 缓存路径
    vim.g.base46_cache = "${base46-cache}/"

    -- 加载核心缓存文件
    pcall(function()
      dofile(vim.g.base46_cache .. "defaults")
      dofile(vim.g.base46_cache .. "statusline")
      dofile(vim.g.base46_cache .. "tbline")
      dofile(vim.g.base46_cache .. "syntax")
      dofile(vim.g.base46_cache .. "treesitter")
      dofile(vim.g.base46_cache .. "devicons")
      dofile(vim.g.base46_cache .. "term")
      dofile(vim.g.base46_cache .. "navic")
      dofile(vim.g.base46_cache .. "blink")
    end)
  '';

  # 最后加载 nvchad（在所有插件之后）
  extraConfigLuaPost = ''
    require "nvchad"

    require("nvim-web-devicons").setup {
      override = require "nvchad.icons.devicons",
    }
  '';

  # 设置 colorscheme
  colorscheme = "nvchad";
}
