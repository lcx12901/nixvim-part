{
  plugins = {
    copilot-lsp = {
      enable = true;

      lazyLoad.settings = {
        event = [ "InsertEnter" ];
      };

      settings = {
        nes = {
          move_count_threshold = 3;
        };
      };
    };
  };
}
