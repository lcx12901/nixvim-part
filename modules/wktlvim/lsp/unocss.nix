{ self, pkgs, ... }:
{
  lsp.servers.unocss = {
    enable = true;

    package = self.packages.${pkgs.stdenv.hostPlatform.system}.unocss-language-server;
  };
}
