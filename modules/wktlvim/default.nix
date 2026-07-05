{ lib, ... }:
let
  inherit (builtins) readDir;
  by-name = ./plugins;
in
{
  # Plugin by-name directory imports
  imports =
    (lib.mapAttrsToList (name: _: by-name + "/${name}") (
      lib.filterAttrs (_: type: type == "directory") (readDir by-name)
    ))
    ++ [
      # keep-sorted start
      ./dependencies.nix
      ./diagnostic.nix
      ./keymappings.nix
      ./lsp.nix
      ./options.nix
      ./performance.nix
      # keep-sorted end
    ];
}
