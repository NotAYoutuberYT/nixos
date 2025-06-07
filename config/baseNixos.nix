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

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.useOSProber = lib.mkDefault false;

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "24.11";

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image = sharedModules/hyprland/wallpaper.png;

      fonts = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };

        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };

        monospace = {
          package = pkgs.jetbrains-mono;
          name = "JetBrains Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes.terminal = 11.25;
      };
    };

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
        ]
        ++ homeManagerModules
        ++ sharedHomeManagerModules;
    };
  };
}
