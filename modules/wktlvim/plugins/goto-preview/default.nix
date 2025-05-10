{ lib, config, ... }:
{
  plugins.goto-preview = {
    enable = true;

    lazyLoad = {
      settings = {
        event = "BufEnter";
      };
    };
  };

  keymaps = lib.mkIf config.plugins.goto-preview.enable [
    {
      mode = "n";
      key = "<leader>gpd";
      action = "<cmd>lua require('goto-preview').goto_preview_definition()<CR>";
      options.desc = "goto_preview_definition";
    }
    {
      mode = "n";
      key = "<leader>gpt";
      action = "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>";
      options.desc = "goto_preview_type_definition";
    }
    {
      mode = "n";
      key = "<leader>gpi";
      action = "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>";
      options.desc = "goto_preview_implementation";
    }
    {
      mode = "n";
      key = "<leader>gpD";
      action = "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>";
      options.desc = "goto_preview_declaration";
    }
    {
      mode = "n";
      key = "<leader>gP";
      action = "<cmd>lua require('goto-preview').close_all_win()<CR>";
      options.desc = "close_all_win";
    }
    {
      mode = "n";
      key = "<leader>gpr";
      action = "<cmd>lua require('goto-preview').goto_preview_references()<CR>";
      options.desc = "goto_preview_references";
    }
  ];
}
