{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
  };

  outputs = { ... } @ inputs: let
    customLib = import ./customLib/default.nix { inherit inputs; };
  in
    with customLib; {
      nixosConfigurations = {
        desktop = mkSystem ./hosts/desktop/configuration.nix;
        portable = mkSystem ./hosts/portable/configuration.nix;
        envy = mkSystem ./hosts/envy/configuration.nix;
      };

      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
    };
}
