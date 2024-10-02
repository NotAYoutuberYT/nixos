{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:

{
  homeManagerConfig.bundles.desktop.enable = true;

  home.sessionVariables = {
    EDITOR = "nano";
  };
}
