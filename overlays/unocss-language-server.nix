{ flake, ... }:
_final: prev: {
  unocss-language-server = flake.inputs.unocss-language-server.packages.${prev.stdenv.system}.default;
}
