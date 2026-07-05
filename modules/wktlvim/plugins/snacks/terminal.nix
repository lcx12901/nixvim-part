{
  plugins = {
    snacks = {
      settings = {
        terminal = {
          enabled = true;

          win = {
            style = "float";
            relative = "editor";
            row = 0.1;
            col = 0.05;
            width = 0.9;
            height = 0.8;
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

    {
      mode = "n";
      key = "<leader>ue1";
      action = "<cmd>lua Snacks.terminal.toggle(nil, { id = 'term-2' })<CR>";
      options = {
        desc = "Toggle Terminal #2";
      };
    }
    {
      mode = "n";
      key = "<leader>ue2";
      action = "<cmd>lua Snacks.terminal.toggle(nil, { id = 'term-3' })<CR>";
      options = {
        desc = "Toggle Terminal #3";
      };
    }
  ];
}
