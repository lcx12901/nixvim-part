{ config, ... }:
let
  inherit (config) symbol_icons;
in
{
  diagnostics = {
    update_in_insert = true;
    severity_sort = true;

    virtual_text = true;
    virtual_lines = {
      current_line = true;
    };

    float = {
      focused = false;
      style = "minimal";
      border = "rounded";
      source = true;
    };

    jump = {
      float = true;
      severity.__raw = "vim.diagnostic.severity.WARN";
    };

    signs = {
      text = {
        "__rawKey__vim.diagnostic.severity.ERROR" = "${symbol_icons.DiagnosticError}";
        "__rawKey__vim.diagnostic.severity.WARN" = "${symbol_icons.DiagnosticWarn}";
        "__rawKey__vim.diagnostic.severity.HINT" = "${symbol_icons.DiagnosticHint}";
        "__rawKey__vim.diagnostic.severity.INFO" = "${symbol_icons.DiagnosticInfo}";
      };
      texthl = {
        "__rawKey__vim.diagnostic.severity.ERROR" = "DiagnosticError";
        "__rawKey__vim.diagnostic.severity.WARN" = "DiagnosticWarn";
        "__rawKey__vim.diagnostic.severity.HINT" = "DiagnosticHint";
        "__rawKey__vim.diagnostic.severity.INFO" = "DiagnosticInfo";
      };
    };
  };
}
