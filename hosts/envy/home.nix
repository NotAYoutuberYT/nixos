{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:

{
  home.sessionVariables = {
    EDITOR = "nano";
  };
}
