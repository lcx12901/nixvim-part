{ lib, pkgs, ... }:
{
  plugins = {
    windsurf-nvim = {
      enable = true;

      settings = {
        enable_chat = false;
        enable_cmp_source = false; # We use blink.cmp instead of nvim-cmp. The blink source is configured separately in blink/sources.nix.

        tools = {
          curl = lib.getExe pkgs.curl;
          gzip = lib.getExe pkgs.gzip;
          uname = lib.getExe' pkgs.coreutils "uname";
          uuidgen = lib.getExe' pkgs.util-linux "uuidgen";
        };
      };
    };
  };
}
