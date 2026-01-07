{ config, lib, ... }:
{
  plugins = {
    treesitter = {
      enable = true;

      folding.enable = true;
      highlight.enable = true;
      indent.enable = true;

      grammarPackages =
        let
          excludedGrammars = [
            # Size
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

            # Never going to use
          ];
        in
        lib.filter (g: !(lib.elem g.pname excludedGrammars)) config.plugins.treesitter.package.allGrammars;
      nixvimInjections = true;
    };
  };
}
