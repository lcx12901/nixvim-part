{ lib, pkgs, ... }:
{
  lsp.servers.nil_ls = {
    enable = false;

    config.settings = {
      formatting = {
        command = [ "${lib.getExe pkgs.nixfmt}" ];
      };
      nix = {
        flake = {
          autoArchive = true;
        };
      };
    };
  };
}
