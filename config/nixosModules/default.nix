{ customModules, name }:
{
  config,
  lib,
  pkgs,
  ...
}:

customModules.optionalPackages { inherit config; } [
  pkgs.cowsay
  pkgs.sl
  pkgs.nushell
]
