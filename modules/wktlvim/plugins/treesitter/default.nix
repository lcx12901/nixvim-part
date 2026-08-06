{
  config,
  lib,
  ...
}:
{
  plugins = {
    treesitter = {
      enable = lib.mkDefault true;
      folding.enable = true;
      highlight.enable = true;
      indent.enable = true;

      # Disable nixvim's built-in injection queries (we don't need them yet)
      nixvimInjections = false;

      # Whitelist mode: only install grammars we actually use
      grammarPackages =
        let
          whitelist = [
            "tree-sitter-nix"
            "tree-sitter-typescript"
            "tree-sitter-vue"
            "tree-sitter-lua"
            "tree-sitter-rust"
            "tree-sitter-bash"
            "tree-sitter-json"
            "tree-sitter-yaml"
          ];
          grammarSet = lib.genAttrs whitelist (_: true);
        in
        lib.filter (g: grammarSet.${g.pname} or false) config.plugins.treesitter.package.allGrammars;
    };
  };

  keymaps = lib.mkIf config.plugins.treesitter.enable [
    {
      mode = [
        "n"
        "x"
      ];
      key = "<A-o>";
      action.__raw = ''
        function()
          if vim.treesitter.get_parser(nil, nil, { error = false }) then
            vim.treesitter.select("parent", vim.v.count1)
          else
            vim.lsp.buf.selection_range(vim.v.count1)
          end
        end
      '';
      options.desc = "Expand syntax selection";
    }
    {
      mode = "x";
      key = "<A-i>";
      action.__raw = ''
        function()
          if vim.treesitter.get_parser(nil, nil, { error = false }) then
            vim.treesitter.select("child", vim.v.count1)
          else
            vim.lsp.buf.selection_range(-vim.v.count1)
          end
        end
      '';
      options.desc = "Shrink syntax selection";
    }
  ];
}
