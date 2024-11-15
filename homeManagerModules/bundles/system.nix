{ lib, ... }:

{
  homeManagerConfig.git.enable = lib.mkDefault true;
  homeManagerConfig.xdg.enable = lib.mkDefault true;
}
