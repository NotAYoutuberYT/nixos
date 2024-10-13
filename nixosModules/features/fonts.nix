{ pkgs, ... }:

{
  fonts.enableDefaultPackages = true;

  fonts.packages = with pkgs; [
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
    cm_unicode
    corefonts
  ];
}
