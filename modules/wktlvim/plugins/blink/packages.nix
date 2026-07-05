{
  config,
  lib,
  pkgs,
  ...
}:
{
  extraPackages = lib.mkIf config.plugins.blink-cmp.enable (
    with pkgs;
    [
      # blink-cmp-dictionary
      wordnet
    ]
  );

  extraPlugins =
    with pkgs.vimPlugins;
    lib.optionals config.plugins.blink-cmp.enable [
      blink-cmp-npm-nvim
      blink-cmp-yanky
      blink-nerdfont-nvim
    ];
}
