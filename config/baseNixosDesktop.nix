{
  inputs,
  outputs,
  lib,
  config,
  ...
}:

let
  nixosModules = lib.allModules ./nixos;
  homeManagerModules = lib.allModules ./homeManager;

  sharedModules = lib.allSharedModules ./hybridModules;
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
      inputs.disko.nixosModules.disko
      ./stylix.nix
      ./sops.nix
      ./users.nix
      ./desktopHardware.nix
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

    networking.firewall.enable = true;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      backupFileExtension = "bak";

      extraSpecialArgs = {
        inherit inputs;
        lib = lib.extend (_: _: inputs.home-manager.lib);
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
