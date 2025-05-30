{ customModules, pkgs, ... }:

customModules.optionalPackages (
  with pkgs;
  [
    helix
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
