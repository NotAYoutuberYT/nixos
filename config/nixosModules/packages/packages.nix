{ customModules, ... }:
{ pkgs, config, ... }:

customModules.optionalPackages { inherit config; } (
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
  ]
)
