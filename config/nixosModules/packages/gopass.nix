{
  pkgs,
  lib,
  config,
  ...
}:

let
  pinentry-flavor = pkgs.pinentry-curses;
in
{
  options.specialConfig.gopass.enable = lib.mkEnableOption "gopass";

  config = lib.mkIf config.specialConfig.gopass.enable {
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
