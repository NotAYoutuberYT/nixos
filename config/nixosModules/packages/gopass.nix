{ pkgs, lib, ... }:

let
  pinentry-flavor = pkgs.pinentry-curses;
in
{
  options.specialConfig.gopass.enable = lib.mkEnableOption "gopass";

  config = {
    environment.systemPackages = with pkgs; [
      gopass
      pinentry-flavor
    ];

    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pinentry-flavor;
    };
  };
}
