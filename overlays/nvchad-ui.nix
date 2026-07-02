{ flake, ... }:
_final: prev: {
  vimPlugins = prev.vimPlugins.extend (
    _self: super: {
      nvchad-ui = super.nvchad-ui.overrideAttrs (_old: {
        doCheck = false;
      });
    }
  );
}
