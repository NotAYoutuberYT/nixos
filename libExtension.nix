{ inputs }:

inputs.nixpkgs.lib.extend (
  final: super: rec {
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
        super.flatten (
          super.mapAttrsToList (
            file: type: if (type == "directory") then allModules (fullPath file) else (import (fullPath file))
          ) contents
        );

    allSharedModules =
      dir:
      let
        contents = builtins.readDir dir;
        fullPath = fullyQualifiedPath dir;
      in
      if (contents ? "hm_default.nix" || contents ? "os_default.nix") then
        [
          {
            homeManagerModule = import (fullPath "hm_default.nix");
            nixosModule = import (fullPath "os_default.nix");
          }
        ]
      else if (contents ? "default.nix") then
        [
          (import (fullPath "default.nix"))
        ]
      else
        super.flatten (
          super.mapAttrsToList (
            file: type:
            if (type == "directory") then allSharedModules (fullPath file) else (import (fullPath file))
          ) contents
        );
  }
)
