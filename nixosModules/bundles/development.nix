{ lib, ... }:

{
  nixosConfig.rust.enable = lib.mkDefault true;
}
