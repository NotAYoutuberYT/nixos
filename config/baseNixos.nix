{
  inputs,
  customLib,
  lib,
  ...
}:
let
  modules = customLib.allModules ./nixosModules;
in
{
  imports = [
    inputs.lix-module.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.nur.modules.nixos.default
    inputs.sops-nix.nixosModules.sops
  ] ++ modules;

  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    time.timeZone = "America/Denver";
    i18n.defaultLocale = "en_US.UTF-8";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.useOSProber = lib.mkDefault false;

    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "24.11";
  };
}
