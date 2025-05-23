{ lib, config, ... }:
{
  plugins.toggleterm = {
    enable = true;

    lazyLoad = {
      settings = {
        cmd = "ToggleTerm";
        keys = [
          "<leader>tt"
          "<leader>tl"
        ];
      };
    };

    settings = {
      direction = "float";
      shading_factor = 2;
      float_opts.border = "rounded";
      highlights = {
        Normal = {
          link = "Normal";
        };
        NormalNC = {
          link = "NormalNC";
        };
        NormalFloat = {
          link = "NormalFloat";
        };
        FloatBorder = {
          link = "FloatBorder";
        };
        StatusLine = {
          link = "StatusLine";
        };
        StatusLineNC = {
          link = "StatusLineNC";
        };
        WinBar = {
          link = "WinBar";
        };
        WinBarNC = {
          link = "WinBarNC";
        };
      };
      on_create.__raw = ''
        function(t)
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.signcolumn = "no"
          if t.hidden then
            local function toggle() t:toggle() end
            vim.keymap.set({ "n", "t", "i" }, "<C-'>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
            vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
          end
        end
      '';
    };
  };

  keymaps = lib.mkIf config.plugins.toggleterm.enable [
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>ToggleTerm<CR>";
      options = {
        desc = "Open Terminal";
      };
    }
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>ToggleTerm<CR>";
      options = {
        desc = "Open Terminal";
      };
    }
    {
      mode = "n";
      key = "<Leader>tl";
      action.__raw = ''
        function()
          local astro = require "astrocore"
          local worktree = astro.file_worktree()
          local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
            or ""
          astro.toggle_term_cmd { cmd = "lazygit " .. flags, direction = "float" }
        end
      '';
      options = {
        desc = "ToggleTerm lazygit";
      };
    }
    {
      mode = "n";
      key = "<F7>";
      action.__raw = ''
        '<Cmd>execute v:count . "ToggleTerm"<CR>'
      '';
      options = {
        desc = "Toggle terminal";
      };
    }
    {
      mode = "t";
      key = "<F7>";
      action = "<Cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal";
    }
    {
      mode = "i";
      key = "<F7>";
      action = "<Esc><Cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal";
    }
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Switch to normal mode";
    }
  ];
}
