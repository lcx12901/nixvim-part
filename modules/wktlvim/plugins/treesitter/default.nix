{ config, lib, ... }:
{
  plugins = {
    treesitter = {
      enable = true;

      folding.enable = true;

      grammarPackages =
        let
          # Large grammars that are not used
          excludedGrammars = [
            "tree-sitter-agda"
            "tree-sitter-apex"
            "tree-sitter-arduino"
            "tree-sitter-blade"
            "tree-sitter-c3"
            "tree-sitter-cuda"
            "tree-sitter-d"
            "tree-sitter-elixir"
            "tree-sitter-fortran"
            "tree-sitter-gnuplot"
            "tree-sitter-hack"
            "tree-sitter-haskell"
            "tree-sitter-hlsl"
            "tree-sitter-hoon"
            "tree-sitter-idris"
            "tree-sitter-ispc"
            "tree-sitter-julia"
            "tree-sitter-kotlin"
            "tree-sitter-koto"
            "tree-sitter-latex"
            "tree-sitter-lean"
            "tree-sitter-nim"
            "tree-sitter-ocaml"
            "tree-sitter-ocaml_interface"
            "tree-sitter-odin"
            "tree-sitter-perl"
            "tree-sitter-purescript"
            "tree-sitter-qmljs"
            "tree-sitter-razor"
            "tree-sitter-ruby"
            "tree-sitter-scala"
            "tree-sitter-slang"
            "tree-sitter-systemverilog"
            "tree-sitter-tlaplus"
            "tree-sitter-unison"
            "tree-sitter-v"
            "tree-sitter-verilog"
            "tree-sitter-vhdl"
          ];
        in
        lib.filter (g: !(lib.elem g.pname excludedGrammars)) config.plugins.treesitter.package.allGrammars;
      nixvimInjections = true;

      settings = {
        highlight = {
          additional_vim_regex_highlighting = true;
          enable = true;
          disable = ''
            function(lang, bufnr)
              return vim.api.nvim_buf_line_count(bufnr) > 10000
            end
          '';
        };

        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<A-o>";
            node_incremental = "<A-o>";
            scope_incremental = "<A-O>";
            node_decremental = "<A-i>";
          };
        };

        indent = {
          enable = true;
        };
      };
    };
  };
}
