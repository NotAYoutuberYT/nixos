{ pkgs, ... }:

let
  pinentry-flavor = pkgs.pinentry-curses;
in
{
  environment.systemPackages = with pkgs; [
    gopass
    pinentry-flavor
  ];

  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pinentry-flavor;
  };
}
