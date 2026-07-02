{
  vimPlugins,
  stdenvNoCC,
  writeText,
  neovim,
  chadrc ? { },
  lib,
  ...
}:
let
  inherit (vimPlugins) base46 nvchad-ui;
  chadrc-lua = writeText "chadrc.lua" ''
    local M = ${lib.generators.toLua { } chadrc}
    return M
  '';
in
stdenvNoCC.mkDerivation {
  src = base46;
  pname = "base46-cache";
  inherit (base46) version;

  buildInputs = [ neovim ];

  buildPhase = ''
    cp ${chadrc-lua} lua/chadrc.lua
    mkdir cache

    substituteInPlace lua/base46/init.lua \
      --replace-warn "cache_path = vim.g.base46_cache" 'cache_path = "'$PWD/cache'/"' \
      --replace-warn "if not vim.uv.fs_stat(vim.g.base46_cache) then" "if false then" \
      --replace-warn "loadstring" "load"

    nvim --headless --noplugin \
      "+lua package.path = package.path .. ';lua/?.lua;lua/?/init.lua;${nvchad-ui}/lua/?.lua;${nvchad-ui}/lua/?/init.lua'" \
      "+lua require('base46').compile()" \
      "+qa" 2>/dev/null || true
  '';

  installPhase = ''
    mkdir $out
    cp -r cache/* $out/
  '';
}
