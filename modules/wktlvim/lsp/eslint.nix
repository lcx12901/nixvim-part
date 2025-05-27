{
  lsp.servers.eslint = {
    enable = true;

    settings = {
      filetypes = [
        "javascript"
        "javascriptreact"
        "javascript.jsx"
        "typescript"
        "typescriptreact"
        "typescript.tsx"
        "vue"
        "json"
        "jsonc"
        "yaml"
        "css"
        "less"
        "scss"
        "postcss"
      ];
      root_markers = [
        "eslint.config.mjs"
      ];
      customizations =
        let
          disableRule = patterns: {
            rule = patterns;
            severity = "off";
            fixable = true;
          };
        in
        map disableRule [
          "style/*"
          "format/*"
          "*-indent"
          "*-spacing"
          "*-spaces"
          "*-order"
          "*-dangle"
          "*-newline"
          "*quotes"
          "*semi"
        ];
    };
  };
}
