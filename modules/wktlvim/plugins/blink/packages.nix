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

  extraPlugins = with pkgs.vimPlugins; [
    blink-cmp-conventional-commits
    blink-cmp-yanky
    blink-nerdfont-nvim
  ];
}
