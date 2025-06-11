{
  inputs,
  outputs,
  pkgs,
  lib,
  customLib,
  config,
  ...
}:

let
  nixosModules = customLib.allModules ./nixosModules;
  homeManagerModules = customLib.allModules ./homeManagerModules;

  sharedModules = customLib.allSharedModules ./sharedModules;
  sharedNixosModules = map (sharedModule: sharedModule.nixosModule) sharedModules;
  sharedHomeManagerModules = map (sharedModule: sharedModule.homeManagerModule) sharedModules;
in
{
  imports =
    [
      inputs.lix-module.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      inputs.nur.modules.nixos.default
      inputs.sops-nix.nixosModules.sops
      inputs.stylix.nixosModules.stylix
      ./stylix.nix
      ./sops.nix
      ./users.nix
    ]
    ++ nixosModules
    ++ sharedNixosModules;

  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    time.timeZone = "America/Denver";
    i18n.defaultLocale = "en_US.UTF-8";

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "24.11";

    environment.systemPackages = [ pkgs.corefonts ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      backupFileExtension = "bak";

      extraSpecialArgs = {
        inherit inputs customLib;
        outputs = inputs.self.outputs;
      };

      users.${config.specialConfig.username}.imports =
        [
          config.specialConfig.hostHomeConfigModule
          outputs.homeManagerModules.default
          inputs.nixcord.homeModules.nixcord
        ]
        ++ homeManagerModules
        ++ sharedHomeManagerModules;
    };
  };
}
