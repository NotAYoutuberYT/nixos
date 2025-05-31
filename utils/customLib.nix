{ inputs }:
let
  lib = inputs.nixpkgs.lib;
  outputs = inputs.self.outputs;

  customLib = (import ./customLib.nix) { inherit inputs; };
in
rec {
  # ====================== Filesystem Helpers ====================== #

  fileNameOf = path: (builtins.head (builtins.split "\\." (baseNameOf path)));
  fullyQualifiedPath = dir: fname: dir + "/${fname}";

  # recursively finds and returns all custom modules in a directory. if a directory contains default.nix, that is
  # the only module returned; otherwise every file in the directory is returned and the recursion continues.
  allModules =
    dir:
    let
      contents = builtins.readDir dir;
      fullPath = fullyQualifiedPath dir;
    in
    if (contents ? "default.nix") then
      [
        (import (fullPath "default.nix"))
      ]
    else
      lib.flatten (
        lib.mapAttrsToList (
          file: type:
          if (type == "directory") then
            allModules (fullPath file)
          else
            (import (fullPath file))
        ) (builtins.readDir dir)
      );

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
