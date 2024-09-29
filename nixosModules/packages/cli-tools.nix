{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    git
    gh
  ];
}