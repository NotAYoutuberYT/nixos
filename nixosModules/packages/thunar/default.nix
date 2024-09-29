{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    xfce.thunar
  ];
}
