{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lix.url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
    lix.flake = false;

    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";
    lix-module.inputs.lix.follows = "lix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    rose-pine-hyprcursor.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    { nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystemPassThrough (
      system:
      let
        customLib = import ./utils/customLib.nix { inherit inputs; };
        pkgs = import nixpkgs { inherit system; };
      in
      {
        formatter.${system} = pkgs.nixfmt-tree;

        homeManagerModules.default = ./config/baseHomeManager.nix;
        nixosModules.default = ./config/baseNixos.nix;

        nixosConfigurations = with customLib; {
          desktop = makeSystem ./config/hosts/desktop/configuration.nix;
          envy = makeSystem ./config/hosts/envy/configuration.nix;
        };
      }
    );
}
