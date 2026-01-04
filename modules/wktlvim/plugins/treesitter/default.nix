{ pkgs, ... }:
{
  plugins = {
    treesitter = {
      enable = true;

      folding.enable = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        css
        diff
        dockerfile
        git_config
        git_rebase
        gitattributes
        gitcommit
        gitignore
        html
        http
        ini
        javascript
        json
        kdl
        lua
        markdown
        markdown_inline
        nginx
        nix
        python
        query
        regex
        rust
        scss
        toml
        tsx
        typescript
        vim
        vimdoc
        vue
        xml
        yaml
      ];
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
