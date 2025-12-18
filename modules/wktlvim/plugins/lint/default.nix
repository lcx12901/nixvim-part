{
  lib,
  pkgs,
  config,
  ...
}:
{
  plugins = {
    lint = {
      enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";

      lintersByFt = {
        bash = [ "shellcheck" ];
        fish = [ "fish" ];
        html = [ "htmlhint" ];
        lua = [ "luacheck" ];
        markdown = [ "markdownlint" ];
        nix = [
          "deadnix"
        ]
        ++ lib.optionals (!config.plugins.lsp.servers.statix.enable) [ "statix" ];
        sh = [ "shellcheck" ];
        sql = [ "sqlfluff" ];
      };

      linters = {
        deadnix.cmd = lib.getExe pkgs.deadnix;
        fish.cmd = lib.getExe pkgs.fish;
        htmlhint.cmd = lib.getExe pkgs.htmlhint;
        luacheck.cmd = lib.getExe pkgs.luaPackages.luacheck;
        markdownlint.cmd = lib.getExe pkgs.markdownlint-cli;
        nix.cmd = lib.getExe' pkgs.nix "nix-instantiate";
        shellcheck.cmd = lib.getExe pkgs.shellcheck;
        sqlfluff.cmd = lib.getExe pkgs.sqlfluff;
        statix.cmd = lib.getExe pkgs.statix;
      };
    };
  };
}
