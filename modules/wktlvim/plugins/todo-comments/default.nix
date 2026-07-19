{ config, lib, ... }: {
  plugins.todo-comments = {
    # See: https://github.com/folke/todo-comments.nvim
    enable = true;

    keymaps = {
      todoTrouble.key = lib.mkIf config.plugins.trouble.enable "<leader>xq";
      # Fallback if snacks picker not enabled
    };
  };

  keymaps = lib.mkIf config.plugins.todo-comments.enable [
    {
      mode = "n";
      key = "<leader>ft";
      action = ''<CMD>lua Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" }})<CR>'';
      options = {
        desc = "Find TODOs";
      };
    }
  ];
}
