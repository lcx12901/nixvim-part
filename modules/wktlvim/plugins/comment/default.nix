{
  plugins = {
    comment = {
      enable = true;

      settings = {
        opleader = {
          block = "gb";
          line = "gc";
        };

        toggler = {
          block = "gbc";
          line = "gcc";
        };

        extra = {
          above = "gcO";
          below = "gco";
          eol = "gcA";
        };

        pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
      };
    };
  };
}
