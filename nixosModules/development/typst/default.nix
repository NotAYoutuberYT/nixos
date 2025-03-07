{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    typst
    tinymist
    typstyle
  ];
}
