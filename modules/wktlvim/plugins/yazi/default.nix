{
  plugins = {
    yazi = {
      enable = true;

      lazyLoad = {
        settings = {
          cmd = [
            "Yazi"
          ];
        };
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>e";
        icon = "󰪶";
      }
      {
        __unkeyed-1 = "<leader>E";
        icon = "󰪶";
      }
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<CMD>Yazi<CR>";
      options = {
        desc = "Yazi (current file)";
      };
    }
    {
      mode = "n";
      key = "<leader>E";
      action = "<CMD>Yazi toggle<CR>";
      options = {
        desc = "Yazi (resume)";
      };
    }
  ];
}
