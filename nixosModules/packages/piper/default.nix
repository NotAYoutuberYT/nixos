{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    piper
    libratbag
  ];
}
