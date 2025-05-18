{ customModules, pkgs, ... }:

customModules.optionalPackages (
  with pkgs;
  [
    alacritty
    lf
    pavucontrol
    spotify
    starship
    vscodium
    waybar
    zoxide
    thefuck
  ]
)
