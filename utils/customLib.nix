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

  # takes module arguments and injects curried custom modules into them
  fullMargs =
    {
      margs,
      name,
      configNamespace,
    }:
    let
      populatedModules = customModules {
        inherit name configNamespace;
        config = margs.config;
        osConfig = margs.osConfig;
      };
    in
    (lib.mergeAttrs margs {
      inherit name configNamespace;
      customModules = populatedModules;
    });

  # recursively finds and returns all custom modules in a directory. if a directory contains default.nix, that is
  # the only module returned; otherwise every file in the directory is returned and the recursion continues.
  allModules = dir: configNamespace: (allModulesWithHead (fileNameOf dir) dir configNamespace);

  allModulesWithHead =
    headName: dir: configNamespace:
    let
      contents = builtins.readDir dir;
      fullPath = fullyQualifiedPath dir;
    in
    if (contents ? "default.nix") then
      [
        (
          { pkgs, ... }@margs:
          (import (fullPath "default.nix")) (fullMargs {
            inherit margs configNamespace;
            name = headName;
          })
        )
      ]
    else
      lib.flatten (
        lib.mapAttrsToList (
          file: type:
          if (type == "directory") then
            allModulesWithHead file (fullPath file) configNamespace
          else
            { pkgs, ... }@margs:
            (import (fullPath file)) (fullMargs {
              inherit margs configNamespace;
              name = lib.removeSuffix ".nix" file;
            })
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
          ;
      };
      modules = [
        config
        outputs.nixosModules.default
      ];
    };
}
