{
  plugins.blink-indent = {
    enable = true;

    lazyLoad.settings = {
      event = [
        "DeferredUIEnter"
      ];
    };

    settings = {
      scope = {
        enabled = true;
        char = "▎";
        priority = 1000;
        highlights = [
          "BlinkIndentOrange"
          "BlinkIndentYellow"
          "BlinkIndentGreen"
          "BlinkIndentCyan"
          "BlinkIndentBlue"
          "BlinkIndentViolet"
        ];
      };
    };
  };
}
