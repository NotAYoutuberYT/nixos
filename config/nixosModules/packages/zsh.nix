{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.specialConfig.zsh.enable = lib.mkEnableOption "zsh" // {
    default = config.specialConfig.shell == pkgs.zsh;
  };

  config = lib.mkIf config.specialConfig.zsh.enable {
    programs.zsh.enable = true;
  };
}
