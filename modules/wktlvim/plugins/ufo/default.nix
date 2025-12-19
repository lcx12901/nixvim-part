{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ promise-async ];

  plugins.nvim-ufo = {
    enable = true;

    lazyLoad.settings.event = "LspAttach";

    settings = {
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
                :catch(function(err)
                  return handleFallbackException(bufnr, err, "treesitter")
                end)
                :catch(function(err)
                  return handleFallbackException(bufnr, err, "indent")
                end)
            end
        end,
      '';
    };
  };

  keymapsOnEvents.LspAttach = [
    {
      key = "<leader>zR";
      mode = "n";
      action.__raw = ''require('ufo').openAllFolds'';
      options = {
        desc = "Open all folds";
      };
    }
    {
      key = "<leader>zM";
      mode = "n";
      action.__raw = ''require("ufo").closeAllFolds'';
      options = {
        desc = "Close all folds";
      };
    }
    {
      key = "<leader>zr";
      mode = "n";
      action.__raw = ''function() require("ufo").openFoldsExceptKinds() end'';
      options = {
        desc = "Fold less";
      };
    }
    {
      key = "<leader>zm";
      mode = "n";
      action.__raw = ''function() require("ufo").closeFoldsWith() end'';
      options = {
        desc = "Fold more";
      };
    }
    {
      key = "<leader>zp";
      mode = "n";
      action.__raw = ''function() require("ufo").peekFoldedLinesUnderCursor() end'';
      options = {
        desc = "Peek fold";
      };
    }
  ];
}
