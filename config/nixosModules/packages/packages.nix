{ customModules, ... }:
{ pkgs, config, ... }:

customModules.optionalPackages { inherit config; } (
  with pkgs;
  [
    alacritty
    git
    lf
    pavucontrol
    spotify
    starship
    vscodium
    waybar
    zoxide
  ]
)
