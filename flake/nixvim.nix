{
  inputs,
  self,
  ...
}:
{
  imports = [
    inputs.nixvim.flakeModules.default
  ];

  nixvim = {
    packages.enable = true;
    checks.enable = true;
  };

  flake.nixvimModules = {
    default = ../modules/wktlvim;
  };

  perSystem =
    { system, ... }:
    let
      sharedNixpkgs = import inputs.nixpkgs {
        inherit system;
        overlays = lib.attrValues self.overlays;
        config.allowUnfree = true;
      };
      lib = inputs.nixpkgs.lib;
    in
    {
      nixvimConfigurations = {
        wktlvim = inputs.nixvim.lib.evalNixvim {
          inherit system;

          extraSpecialArgs = {
            inherit inputs system self;
          };

          modules = [
            self.nixvimModules.default
            # Pass overlay'd pkgs to nixvim's module system
            {
              nixpkgs.pkgs = sharedNixpkgs;
              nixpkgs.config = lib.mkForce { };
            }
          ];
        };
      };
    };
}
