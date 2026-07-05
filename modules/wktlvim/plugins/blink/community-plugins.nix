{ config, ... }:
let
  blinkEnabled = true;
  mkBlinkPlugin =
    {
      enable ? true,
      ...
    }@args:
    {
      enable = blinkEnabled && enable;
      lazyLoad.settings.event = [
        "InsertEnter"
        "CmdlineEnter"
      ];
    }
    // (removeAttrs args [ "enable" ]);
in
{
  plugins = {
    # keep-sorted start block=yes
    blink-cmp-avante = mkBlinkPlugin {
      inherit (config.plugins.avante) enable;
    };
    blink-cmp-dictionary = mkBlinkPlugin {
      enable = true;
    };
    blink-cmp-spell = mkBlinkPlugin { };
    blink-cmp-words = mkBlinkPlugin {
      enable = false;
    };
    blink-emoji = mkBlinkPlugin { };
    blink-ripgrep = mkBlinkPlugin { };
    # keep-sorted end
  };
}
