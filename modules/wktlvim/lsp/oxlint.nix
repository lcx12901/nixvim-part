{
  lsp.servers.oxlint = {
    enable = true;

    settings = {
      filetypes = [
        "javascript"
        "javascriptreact"
        "typescript"
        "typescriptreact"
        "typescript.tsx"
        "vue"
        "astro"
        "svelte"
      ];
      root_markers = [
        ".oxlintrc.json"
      ];
    };
  };
}
