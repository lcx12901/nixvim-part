{ pkgs, ... }:
{
  lsp.servers.volar = {
    enable = true;
    settings = {
      init_options = {
        vue = {
          hybridMode = true;
        };
        typescript = {
          tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";

          inlayHints = {
            parameterNames.enabled = "all";
            variableTypes.enabled = true;
            propertyDeclarationTypes.enabled = true;
            functionLikeReturnTypes.enabled = true;
            enumMemberValues.enabled = true;
          };
        };
      };
    };
  };
}
