{ lib, ... }:
{
  plugins.rainbow-delimiters = {
    enable = true;

    settings = {
      strategy = {
        "" = lib.nixvim.mkRaw "require 'rainbow-delimiters'.strategy['global']";
        nix = lib.nixvim.mkRaw "require 'rainbow-delimiters'.strategy['local']";
      };
    };
  };
}
