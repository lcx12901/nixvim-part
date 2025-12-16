{
  vimUtils,
  pkgs,
}:
vimUtils.buildVimPlugin {
  pname = "ts-error-translator";
  version = "2.0.1";

  src = pkgs.fetchFromGitHub {
    owner = "dmmulroy";
    repo = "ts-error-translator.nvim";
    rev = "c1e6a5529009e855eb102a668549679548757a05";
    hash = "sha256-/eLbUkjFpAneMoITdknATvpDjnA5XMUjEKaDq0CG+ys=";
  };
}
