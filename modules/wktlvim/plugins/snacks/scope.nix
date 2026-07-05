{
  config,
  lib,
  ...
}:
{
  plugins = {
    snacks = {
      settings = {
        scope = {
          enabled = true;

          treesitter = {
            blocks = {
              enabled = true; # use treesitter for semantic scope detection
            };
          };
        };
      };
    };
  };
}
