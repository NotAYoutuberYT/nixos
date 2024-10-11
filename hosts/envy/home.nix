{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:

{
  homeManagerConfig.bundles.desktop.enable = true;
  homeManagerConfig.bundles.system.enable = true;

  home.sessionVariables = {
    EDITOR = "nano";
  };
}
