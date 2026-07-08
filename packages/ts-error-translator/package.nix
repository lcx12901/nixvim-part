{
  vimUtils,
  pkgs,
}:
vimUtils.buildVimPlugin {
  pname = "ts-error-translator";
  version = "unstable-2026-01-04";

  src = pkgs.fetchFromGitHub {
    owner = "dmmulroy";
    repo = "ts-error-translator.nvim";
    rev = "558abff11b9e8f4cefc0de09df780c56841c7a4b";
    hash = "sha256-kjZwfvb0B7GC4dBBSdgC/zRmCUCfCm4H5J+8SFzANJ4=";
  };
}
