{
  inputs,
  lib,
  self,
  ...
}:
{
  imports = [
    ./nixvim.nix
    ./pkgs-by-name.nix
  ];

  perSystem =
    {
      config,
      system,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = lib.attrValues self.overlays;
        config.allowUnfree = true;
      };

      packages.default = config.packages.wktlvim;
    };
}
