{ config, ... }:
{
  plugins = {
    lualine.settings.options.theme = "catppuccin";
  };

  colorschemes.catppuccin = {
    lazyLoad.enable = config.plugins.lz-n.enable;

    settings = {
      default_integrations = true;
      dim_inactive = {
        enabled = false;
        percentage = 0.25;
      };

      flavour = "macchiato";

      show_end_of_buffer = true;
      term_colors = true;
    };
  };
}
