{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    flake-utils.url = "github:numtide/flake-utils";
    nix-colors.url = "github:misterio77/nix-colors";

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystemPassThrough (
      system:
      let
        customLib = import ./customLib/default.nix { inherit inputs; };
      in
      with customLib;
      {
        nixosConfigurations = {
          desktop = mkSystem ./hosts/desktop/configuration.nix;
          envy = mkSystem ./hosts/envy/configuration.nix;
        };

        homeManagerModules.default = ./homeManagerModules;
        nixosModules.default = ./nixosModules;

        formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
      }
    );
}
