{
  description = "nvim in nixos";

  inputs = {
    # Core Nix ecosystem
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Applications & packages
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        # Required inputs
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    unocss-language-server.url = "github:xna00/unocss-language-server";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];
      imports = [
        ./flake
      ];
    };
}
