{
  imports = [
    ./bufdelete.nix
    ./lazygit.nix
    ./picker.nix
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
        quickfile.enabled = true;
      };
    };
  };
}
