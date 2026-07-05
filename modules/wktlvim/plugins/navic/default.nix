{
  plugins.navic = {
    enable = true;

    lazyLoad.settings.event = [
      "BufReadPost"
      "BufNewFile"
    ];

    settings = {
      lsp = {
        auto_attach = true;
        preference = [
          "clangd"
          "tsserver"
        ];
      };
      highlight = true;
    };
  };

  extraConfigLuaPost = ''
    -- 设置 navic winbar（在 tabufline 下方显示代码上下文）
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  '';
}
