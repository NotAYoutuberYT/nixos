{ inputs, customLib }:

let
  outputs = inputs.self.outputs;
in
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
}
