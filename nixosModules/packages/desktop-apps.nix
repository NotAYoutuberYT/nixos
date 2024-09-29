{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    librewolf
    xfce.thunar
    pavucontrol
    keepassxc
  ];
}