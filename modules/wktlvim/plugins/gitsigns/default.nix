{ config, ... }:
let
  inherit (config) symbol_icons;
in
{
  plugins.gitsigns = {
    enable = true;

    lazyLoad.settings.event = "DeferredUIEnter";

    settings = {
      current_line_blame = true;

      current_line_blame_opts = {
        delay = 500;

        ignore_blank_lines = true;
        ignore_whitespace = true;
        virt_text = true;
        virt_text_pos = "eol";
      };

      signs = {
        add.text = symbol_icons.GitSign;
        change.text = symbol_icons.GitSign;
        changedelete.text = symbol_icons.GitSign;
        delete.text = symbol_icons.GitSign;
        topdelete.text = symbol_icons.GitSign;
        untracked.text = symbol_icons.GitSign;
      };

      signcolumn = true;
    };
  };
}
