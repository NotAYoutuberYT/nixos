{ pkgs, ... }:

{
  users.users.bryce = {
    isNormalUser = true;
    description = "Bryce";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };
}