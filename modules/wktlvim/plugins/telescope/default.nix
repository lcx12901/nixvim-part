{ lib, config, ... }:
{
  plugins.telescope = {
    enable = false;

    lazyLoad.settings.cmd =
      [ "Telescope" ]
      ++ lib.optionals config.plugins.noice.enable [
        "Noice telescope"
      ];

    highlightTheme = "Catppuccin Macchiato";

    settings = {
      defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
        ];
        set_env.COLORTERM = "truecolor";
      };

      pickers = {
        colorscheme = {
          enable_preview = true;
        };
      };
    };
  };
}
