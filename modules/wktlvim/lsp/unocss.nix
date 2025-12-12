{ self, system, ... }:
{
  lsp.servers.unocss = {
    enable = true;

    package = self.packages.${system}.unocss-language-server;

  };
}
