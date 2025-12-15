{
  plugins.tiny-inline-diagnostic = {
    enable = true;

    lazyLoad.settings.event = "LspAttach";

    settings = {
      multilines.enabled = true;
      options = {
        show_source.enabled = true;
        break_line.enabled = true;
      };
      preset = "amongus";
    };
  };
}
