{
  plugins = {
    snacks = {
      settings = {
        lazygit.enabled = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>tl";
      action = "<cmd>lua Snacks.lazygit()<CR>";
      options = {
        desc = "Open lazygit";
      };
    }
  ];
}
