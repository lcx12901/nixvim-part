_: _final: prev: {
  vimPlugins = prev.vimPlugins.extend (
    plugins: prevPlugins: {
      # Update nvim-lspconfig to fix https://github.com/nix-community/nixvim/issues/3224
      # TODO: remove once nixpkgs updates vimPlugins
      nvim-lspconfig = prevPlugins.nvim-lspconfig.overrideAttrs {
        src = _final.fetchFromGitHub {
          owner = "neovim";
          repo = "nvim-lspconfig";
          rev = "c48fac0936f24a5a2dbea9c8379ec9414a45eb8b";
          hash = "sha256-L/yz0egBCIJ9kIDoZzX/+9GHx2au2VtlOPkm+zZ+T7M=";
        };
      };
    }
  );
}
