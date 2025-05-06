{ inputs }:
let
  lib = inputs.nixpkgs.lib;
  outputs = inputs.self.outputs;

  customLib = (import ./customLib.nix) { inherit inputs; };
  customModules = (import ./customModules.nix) { inherit lib customLib; };
in
rec {
  # ====================== Filesystem Helpers ====================== #

  fileNameOf = path: (builtins.head (builtins.split "\\." (baseNameOf path)));
  fullyQualifiedPath = dir: fname: dir + "/${fname}";

  # ===================++=== Module Helpers ============++========== #

  # takes a module, moves everything into config if config does net yet exist, and returns
  cleanModule =
    module:
    if ((module ? "config") || (module ? "options") || (module ? "imports")) then
      module
    else
      { config = module; };

  # recursively finds and returns all custom modules in a directory. if a directory contains default.nix, that is
  # the only module returned; otherwise every file in the directory is returned and the recursion continues.
  allModules = dir: (allModulesWithHead (fileNameOf dir) dir);

  allModulesWithHead =
    headName: dir:
    let
      contents = builtins.readDir dir;
      fullPath = fullyQualifiedPath dir;
    in
    if (contents ? "default.nix") then
      [
        (import (fullPath "default.nix") ({ inherit customModules; } // { name = headName; }))
      ]
    else
      lib.flatten (
        lib.mapAttrsToList (
          file: type:
          if (type == "directory") then
            allModulesWithHead file (fullPath file)
          else
            (import (fullPath file)) ({ inherit customModules; } // { name = lib.removeSuffix ".nix" file; })
        ) (builtins.readDir dir)
      );

  # ========================= Misc Helpers ========================= #

  packageName = package: lib.removeSuffix "-${package.version}" package.name;

  # =========================== Builders =========================== #

  makeSystem =
    config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          outputs
          customLib
          customModules
          ;
      };
      modules = [
        config
        outputs.nixosModules.default
      ];
    };
}
