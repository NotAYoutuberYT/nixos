{ pkgs, inputs, ... }:

{
  fonts.enableDefaultPackages = true;

  fonts.packages = with pkgs; [
    nerdfonts
  ];
}
