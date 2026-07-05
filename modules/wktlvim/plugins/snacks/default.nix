{
  imports = [
    ./bufdelete.nix
    ./lazygit.nix
    ./picker.nix
    ./scope.nix
    ./terminal.nix
  ];

  plugins = {
    snacks = {
      enable = true;

      settings = {
        indent.enabled = true;
        input.enabled = true;
        statuscolumn = {
          enabled = true;
          folds = {
            open = true;
            git_hl = true;
          };
        };
        quickfile.enabled = true;
        styles = {
          input = {
            relative = "cursor";
            row = -4;
            col = 0;
          };
        };
      };
    };
  };
}
