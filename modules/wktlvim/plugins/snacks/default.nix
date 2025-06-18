{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) symbol_icons;
in
{
  imports = [
    ./picker.nix
    ./zen.nix
  ];

  extraPackages = with pkgs; [
    # PDF rendering
    ghostscript
    # Mermaid diagrams
    mermaid-cli
    # LaTeX
    tectonic
  ];

  plugins = {
    snacks = {
      enable = true;

      settings = {
        image.enabled = true;
        scroll.enabled = true;
        indent = {
          enabled = true;
          indent = {
            char = "▏";
          };
          scope = {
            char = "▏";
          };
          filter.__raw = ''
            function(bufnr)
              local buf_utils = require "astrocore.buffer"
              return buf_utils.is_valid(bufnr)
                and not buf_utils.is_large(bufnr)
                and vim.g.snacks_indent ~= false
                and vim.b[bufnr].snacks_indent ~= false
            end
          '';
        };
        notifier = {
          enabled = true;
          icons = {
            debug = symbol_icons.Debugger;
            error = symbol_icons.DiagnosticError;
            warn = symbol_icons.DiagnosticInfo;
            info = symbol_icons.DiagnosticInfo;
            trace = symbol_icons.DiagnosticHint;
          };
        };
      };
    };
  };

  keymaps =
    lib.optionals (config.plugins.snacks.settings.notifier.enabled) [
      {
        mode = "n";
        key = "<Leader>uD";
        action.__raw = ''function() require("snacks.notifier").hide() end'';
        options.desc = "Dismiss notifications";
      }
    ]
    ++ lib.optionals (config.plugins.snacks.settings.indent.enabled) [
      {
        mode = "n";
        key = "<Leader>u|";
        action.__raw = ''function() require("snacks").toggle.indent():toggle() end'';
        options.desc = "Toggle indent guides";
      }
    ];
}
