{
  imports = [
    ./bufdelete.nix
    ./lazygit.nix
    ./picker.nix
    ./terminal.nix
  ];

  plugins = {
    snacks = {
      enable = true;

      settings = {
        input.enabled = true;
        statuscolumn = {
          enabled = true;

          folds = {
            open = true;
            git_hl = true;
          };
        };
        scroll.enabled = true;
        quickfile.enabled = true;
      };
    };
  };
}
