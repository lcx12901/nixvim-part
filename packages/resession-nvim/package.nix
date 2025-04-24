{ inputs, vimUtils }:
vimUtils.buildVimPlugin {
  pname = "resession-nvim";
  src = inputs.resession-nvim;
  version = inputs.resession-nvim.shortRev;
}
