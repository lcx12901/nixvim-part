{
  plugins.auto-session = {
    enable = true;

    settings = {
      allowed_dirs = [ "~/Coding/*" ];
      use_git_branch = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>wr";
      action = "<cmd>AutoSession search<CR>";
      options = {
        desc = "Session search";
      };
    }
    {
      mode = "n";
      key = "<leader>ws";
      action = "<cmd>AutoSession save<CR>";
      options = {
        desc = "Save session";
      };
    }
    {
      mode = "n";
      key = "<leader>wa";
      action = "<cmd>AutoSession toggle<CR>";
      options = {
        desc = "Toggle autosave";
      };
    }
  ];
}
