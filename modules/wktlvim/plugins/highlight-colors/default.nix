{
  plugins = {
    highlight-colors = {
      enable = true;

      settings = {
        enable_named_colors = false;
        virtual_symbol = "󱓻";
        exclude_buffer.__raw = ''
          function(bufnr)
            local buf_utils = require "astrocore.buffer"
            return buf_utils.is_large(bufnr) or not buf_utils.is_valid(bufnr)
          end
        '';
      };
    };
  };
}
