{ lib, config, ... }:
{
  plugins.nvim-ufo = {
    enable = true;

    lazyLoad.settings.event = [ "InsertEnter" ];

    settings = {
      preview.mappings = {
        scrollB = "<C-B>";
        scrollF = "<C-F>";
        scrollU = "<C-U>";
        scrollD = "<C-D>";
      };

      provider_selector = ''
        function(_, filetype, buftype)
          local function handleFallbackException(bufnr, err, providerName)
            if type(err) == "string" and err:match "UfoFallbackException" then
              return require("ufo").getFolds(bufnr, providerName)
            else
              return require("promise").reject(err)
            end
          end

          return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
            or function(bufnr)
              return require("ufo")
                .getFolds(bufnr, "lsp")
                :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
                :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
            end
        end
      '';
    };
  };

  keymaps = lib.mkIf config.plugins.nvim-ufo.enable [
    {
      mode = "n";
      key = "zR";
      action.__raw = ''function() require("ufo").openAllFolds() end'';
      options.desc = "Open all folds";
    }
    {
      mode = "n";
      key = "zM";
      action.__raw = ''function() require("ufo").closeAllFolds() end'';
      options.desc = "Close all folds";
    }
    {
      mode = "n";
      key = "zr";
      action.__raw = ''function() require("ufo").openFoldsExceptKinds() end'';
      options.desc = "Fold less";
    }
    {
      mode = "n";
      key = "zm";
      action.__raw = ''function() require("ufo").closeFoldsWith() end'';
      options.desc = "Fold more";
    }
    {
      mode = "n";
      key = "zp";
      action.__raw = ''function() require("ufo").peekFoldedLinesUnderCursor() end'';
      options.desc = "Peek fold";
    }
  ];

  opts = lib.mkIf config.plugins.nvim-ufo.enable {
    foldcolumn = "1";
    foldexpr = "0";
    foldenable = true;
    foldlevel = 99;
    foldlevelstart = 99;
  };
}
