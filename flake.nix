{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    rose-pine-hyprcursor.url = "git+https://github.com/ndom91/rose-pine-hyprcursor";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

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

      homeConfigurations = {
       "bryce@desktop" = mkHome "x86_64-linux" ./hosts/desktop/home.nix;
       "bryce@portable" = mkHome "x86_64-linux" ./hosts/portable/home.nix;
       "bryce@envy" = mkHome "x86_64-linux" ./hosts/envy/home.nix;
      };

      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
    };
}
