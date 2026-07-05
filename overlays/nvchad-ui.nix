{ flake, ... }:
_final: prev: {
  vimPlugins = prev.vimPlugins.extend (
    _self: super: {
      nvchad-ui = super.nvchad-ui.overrideAttrs (old: {
        doCheck = false;
        patches = (old.patches or [ ]) ++ [
          ../patches/nvchad-remove-reload-autocmd.patch
        ];
      });
    }
  );
}
