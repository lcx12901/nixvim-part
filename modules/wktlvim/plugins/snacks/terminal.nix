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
      mode = [
        "n"
        "t"
      ];
      key = "<F7>";
      action = "<cmd>lua Snacks.terminal.toggle()<CR>";
      options = {
        desc = "Toggle Terminal";
      };
    }
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Switch to normal mode";
    }
  ];
}
