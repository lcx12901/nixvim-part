{
  plugins = {
    snacks = {
      settings = {
        terminal = {
          enabled = true;

          win = {
            style = "float";
            relative = "editor";
            row = 0.05;
            col = 0.05;
            width = 0.9;
            height = 0.9;
            border = "rounded";
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<C-/>";
      action = "<cmd>lua Snacks.terminal.toggle()<CR>";
      options = {
        desc = "Toggle Terminal";
      };
    }
    {
      mode = "t";
      key = "<C-/>";
      action = "<cmd>lua Snacks.terminal.toggle()<CR>";
      options = {
        desc = "Toggle Terminal";
      };
    }
  ];
}
