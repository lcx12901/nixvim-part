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
    ./overlays.nix
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
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "pnpm-10.34.0"
          ];
        };
      };

      packages.default = config.packages.wktlvim;
    };
}
