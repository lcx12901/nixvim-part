{
  plugins.better-escape = {
    enable = true;

    settings = {
      timeout = "vim.o.timeoutlen";
      default_mappings = false;
      mappings = {
        i = {
          j = {
            j = "<Esc>";
            k = "<Esc>";
          };
        };
      };
    };
  };
}
