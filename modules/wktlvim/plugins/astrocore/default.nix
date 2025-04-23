{ pkgs, ... }:
let
  version = "2.0.1";
in
{

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      inherit version;

      name = "astrocore";

      src = pkgs.fetchFromGitHub {
        owner = "astronvim";
        repo = "astrocore";
        rev = "v${version}";
        hash = "sha256-6c7SeykSpWNcg/cThSAFaHn87rHSAzPKPpWxahGNfRs=";
      };

      patches = [
        ./init.lua.patch
      ];
    })
  ];

  extraConfigLuaPre = ''
    local get_icon = require("astroui").get_icon
    require('astrocore').setup {
      features = {
        large_buf = {
          enabled = function(bufnr) return require("astrocore.buffer").is_valid(bufnr) end,
          notify = true,
          size = 1.5 * 1024 * 1024,
          lines = 100000,
          line_length = 1000,
        },
        autopairs = true, -- enable autopairs at start
        cmp = true, -- enable completion at start
        diagnostics = true, -- enable diagnostics by default
        highlighturl = true, -- highlight URLs by default
        notifications = true, -- disable notifications
      },
    }
  '';
}
