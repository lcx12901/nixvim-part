{ config, lib, ... }: {
  plugins = {
    lint = {
      enable = true;

      autoInstall.enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";

      autoCmd = {
        event = [
          "BufReadPost"
          "BufWritePost"
          "InsertLeave"
        ];
        callback.__raw = ''
          function(args)
            require("lint").try_lint()
          end
        '';
      };

      lintersByFt = {
        nix = [
          "deadnix"
        ]
        ++ lib.optionals (!config.plugins.lsp.servers.statix.enable) [ "statix" ];
      };
    };
  };
}
