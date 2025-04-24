{
  plugins = {
    illuminate = {
      enable = true;

      filetypesDenylist = [
        "dirvish"
        "fugitive"
        "neo-tree"
        "TelescopePrompt"
      ];

      delay = 200;
      minCountToHighlight = 2;
      largeFileCutoff = 3000;
    };
  };
}
