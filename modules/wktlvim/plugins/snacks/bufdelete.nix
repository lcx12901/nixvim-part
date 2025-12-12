{
  extraConfigLuaPre = ''
    -- Disable built-in diagnostic keymaps that conflict with <C-W> closing a buffer
    vim.keymap.del('n', '<C-W>d')
    vim.keymap.del('n', '<C-W><C-D>')
  '';

  plugins = {
    snacks = {
      settings = {
        bufdelete.enabled = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<C-w>";
      action = ''<cmd>lua Snacks.bufdelete.delete()<cr>'';
      options = {
        desc = "Close buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bc";
      action = ''<cmd>lua Snacks.bufdelete.other()<cr>'';
      options = {
        desc = "Close all buffers but current";
      };
    }
    {
      mode = "n";
      key = "<leader>bC";
      action = ''<cmd>lua Snacks.bufdelete.all()<cr>'';
      options = {
        desc = "Close all buffers";
      };
    }
  ];
}
