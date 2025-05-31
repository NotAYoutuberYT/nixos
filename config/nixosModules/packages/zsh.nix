{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.specialConfig.zsh.enable = lib.mkEnableOption "zsh";

  config = {
    programs.zsh.enable = true;
  };
}
