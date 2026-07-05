{
  plugins = {
    snacks = {
      settings = {
        terminal.enabled = true;
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
    {
      mode = "n";
      key = "<leader>ueT";
      action = "<cmd>lua Snacks.terminal.toggle()<CR>";
      options = {
        desc = "Toggle Terminal";
      };
    }
  ];
}
