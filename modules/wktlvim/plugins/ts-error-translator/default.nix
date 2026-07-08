{
  self,
  lib,
  pkgs,
  ...
}:
let
  config = {
    auto_attach = true;
    servers = [
      "astro"
      "svelte"
      "ts_ls"
      "typescript-tools"
      "volar"
      "vtsls"
    ];
  };
in
{
  extraPlugins = [
    self.packages.${pkgs.stdenv.hostPlatform.system}.ts-error-translator
  ];

  extraConfigLua = ''
    require("ts-error-translator").setup(${lib.generators.toLua { } config})
  '';
}
