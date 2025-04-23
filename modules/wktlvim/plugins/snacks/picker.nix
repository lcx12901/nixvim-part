{ config, lib, ... }:
{
  plugins = {
    snacks = {
      enable = true;

      settings = {
        picker = {
          ui_select = true;
        };
      };
    };
  };

  keymaps =
    lib.mkIf (config.plugins.snacks.enable && lib.hasAttr "picker" config.plugins.snacks.settings)
      [
        {
          mode = "n";
          key = "<Leader>gb";
          action.__raw = ''function() require("snacks").picker.git_branches() end'';
          options.desc = "Git branches";
        }
        {
          mode = "n";
          key = "<Leader>gc";
          action.__raw = ''function() require("snacks").picker.git_log() end'';
          options.desc = "Git commits (repository)";
        }
        {
          mode = "n";
          key = "<Leader>gC";
          action.__raw = ''function() require("snacks").picker.git_log { current_file = true, follow = true } end'';
          options.desc = "Git commits (current file)";
        }
        {
          mode = "n";
          key = "<Leader>gt";
          action.__raw = ''function() require("snacks").picker.git_status() end'';
          options.desc = "Git status";
        }
        {
          mode = "n";
          key = "<Leader>gT";
          action.__raw = ''function() require("snacks").picker.git_stash() end'';
          options.desc = "Git stash";
        }
        {
          mode = "n";
          key = "<Leader>f<CR>";
          action.__raw = ''function() require("snacks").picker.resume() end'';
          options.desc = "Resume previous search";
        }
        {
          mode = "n";
          key = "<Leader>f'";
          action.__raw = ''function() require("snacks").picker.marks() end'';
          options.desc = "Find marks";
        }
        {
          mode = "n";
          key = "<Leader>fl";
          action.__raw = ''function() require("snacks").picker.lines() end'';
          options.desc = "Find lines";
        }
        {
          mode = "n";
          key = "<Leader>fb";
          action.__raw = ''function() require("snacks").picker.buffers() end'';
          options.desc = "Find buffers";
        }
        {
          mode = "n";
          key = "<Leader>fc";
          action.__raw = ''function() require("snacks").picker.grep_word() end'';
          options.desc = "Find word under cursor";
        }
        {
          mode = "n";
          key = "<Leader>fC";
          action.__raw = ''function() require("snacks").picker.commands() end'';
          options.desc = "Find commands";
        }
        {
          mode = "n";
          key = "<Leader>ff";
          action.__raw = ''
            function()
              require("snacks").picker.files {
                hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat ".git" or {}, "type") == "directory",
              }
            end
          '';
          options.desc = "Find files";
        }
        {
          mode = "n";
          key = "<Leader>fF";
          action.__raw = ''function() require("snacks").picker.files { hidden = true, ignored = true } end'';
          options.desc = "Find all files";
        }
        {
          mode = "n";
          key = "<Leader>fg";
          action.__raw = ''function() require("snacks").picker.git_files() end'';
          options.desc = "Find git files";
        }
        {
          mode = "n";
          key = "<Leader>fh";
          action.__raw = ''function() require("snacks").picker.help() end'';
          options.desc = "Find help";
        }
        {
          mode = "n";
          key = "<Leader>fk";
          action.__raw = ''function() require("snacks").picker.keymaps() end'';
          options.desc = "Find keymaps";
        }
        {
          mode = "n";
          key = "<Leader>fm";
          action.__raw = ''function() require("snacks").picker.man() end'';
          options.desc = "Find man";
        }
        {
          mode = "n";
          key = "<Leader>fn";
          action.__raw = ''function() require("snacks").picker.notifications() end'';
          options.desc = "Find notifications";
        }
        {
          mode = "n";
          key = "<Leader>fo";
          action.__raw = ''function() require("snacks").picker.recent() end'';
          options.desc = "Find old files";
        }
        {
          mode = "n";
          key = "<Leader>fO";
          action.__raw = ''function() require("snacks").picker.recent { filter = { cwd = true } } end'';
          options.desc = "Find old files (cwd)";
        }
        {
          mode = "n";
          key = "<Leader>fp";
          action.__raw = ''function() require("snacks").picker.projects() end'';
          options.desc = "Find projects";
        }
        {
          mode = "n";
          key = "<Leader>fr";
          action.__raw = ''function() require("snacks").picker.registers() end'';
          options.desc = "Find registers";
        }
        {
          mode = "n";
          key = "<Leader>fs";
          action.__raw = ''function() require("snacks").picker.smart() end'';
          options.desc = "Find buffers/recent/files";
        }
        {
          mode = "n";
          key = "<Leader>fw";
          action.__raw = ''function() require("snacks").picker.grep() end'';
          options.desc = "Find words";
        }
        {
          mode = "n";
          key = "<Leader>fW";
          action.__raw = ''function() require("snacks").picker.grep { hidden = true, ignored = true } end'';
          options.desc = "Find words in all files";
        }
        {
          mode = "n";
          key = "<Leader>fu";
          action.__raw = ''function() require("snacks").picker.undo() end'';
          options.desc = "Find undo history";
        }
        {
          mode = "n";
          key = "<Leader>lD";
          action.__raw = ''function() require("snacks").picker.diagnostics() end'';
          options.desc = "Search diagnostics";
        }
        {
          mode = "n";
          key = "<Leader>ls";
          action.__raw = ''
            function()
              local aerial_avail, aerial = pcall(require, "aerial")
              if aerial_avail and aerial.snacks_picker then
                aerial.snacks_picker()
              else
                require("snacks").picker.lsp_symbols()
              end
            end
          '';
          options.desc = "Search symbols";
        }
      ];
}
