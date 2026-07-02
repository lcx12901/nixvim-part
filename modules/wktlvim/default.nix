{ lib, self, ... }:
let
  inherit (builtins) readDir;
  inherit (lib.attrsets) foldlAttrs;
  inherit (lib.lists) optional;
  by-name = ./plugins;
in
{
  # Plugin by-name directory imports
  imports = (
    foldlAttrs (
      prev: name: type:
      prev ++ optional (type == "directory") (by-name + "/${name}")
    ) [ ] (readDir by-name)
  );
}
