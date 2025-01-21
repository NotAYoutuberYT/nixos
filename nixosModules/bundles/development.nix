{ lib, ... }:

{
  nixosConfig.tex.enable = lib.mkDefault true;
  nixosConfig.typst.enable = lib.mkDefault true;
}
