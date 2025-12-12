{ self, system, ... }:
{
  lsp.servers.unocss_language_server = {
    enable = true;

    package = self.packages.${system}.unocss-language-server;

  };
}
