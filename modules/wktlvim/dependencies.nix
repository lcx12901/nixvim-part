{
  config,
  lib,
  ...
}:
{
  extraLuaPackages =
    ps:
    lib.optionals (config.plugins.sidekick.enable || config.plugins.opencode.enable) [
      ps.tiktoken_core
    ];
}
