{
  plugins.tiny-inline-diagnostic = {
    enable = true;

    settings = {
      options = {
        multilines = {
          enabled = true;
        };
        show_source = {
          enabled = true;
        };
        break_line = {
          enabled = true;
        };
        add_messages = {
          display_count = true;
        };
      };

      preset = "ghost";
    };
  };
}
