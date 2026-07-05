{ lib, pkgs, ... }:
{
  plugins.lsp = {
    enable = true;

    inlayHints = true;

    servers = {
      # Languages
      bashls.enable = true;
      eslint = {
        enable = true;
        settings = {
          format = false;
          nodePath = "${pkgs.eslint}/lib/node_modules";
        };
      };
      emmylua_ls.enable = true;
      jsonls.enable = true;
      marksman.enable = true;
      sqls.enable = true;
      yamlls.enable = true;
      nixd = {
        enable = true;
        settings.nixd = {
          formatting = {
            command = [ "${lib.getExe pkgs.nixfmt}" ];
          };
        };
      };
      vtsls = {
        enable = true;
        settings.vtsls.tsserver.maxTsServerMemory = 4096;
      };
      vue_ls = {
        enable = true;
        vtslsIntegration = true; # auto-wires @vue/typescript-plugin into vtsls
        tslsIntegration = false; # mutually exclusive with vtsls
      };
    };
  };
}
