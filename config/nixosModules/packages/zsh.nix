{ customModules, ... }:
{ config, pkgs, ... }:

customModules.enableIf (config.nixosConfig.shell == pkgs.zsh) {
  programs.zsh.enable = true;
}
