{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.okular
  ];
}
