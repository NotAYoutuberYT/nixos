{ inputs, lib }:

let
  outputs = inputs.self.outputs;
in
{
  desktopSystem =
    config:
    lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs lib;
      };

      modules = [
        config
        outputs.nixosModules.desktop
      ];
    };

  deployNodes =
    devices:
    builtins.listToAttrs (
      map (d: {
        name = d.name;

        value = {
          hostname = d.domain;

          profiles.system = {
            user = "root";
            sshUser = "root";

            sshOpts = [
              "-i"
              d.sshKey
            ];

            path = inputs.deploy-rs.lib.${d.system or "x86_64-linux"}.activate.nixos (
              lib.nixosSystem {
                specialArgs = { inherit inputs outputs lib; };

                modules = [
                  d.configuration
                  outputs.nixosModules.server
                  { config.specialConfig.hosting.device = d; }
                  { config.specialConfig.hosting.devices = import devices; }
                ];
              }
            );
          };
        };
      }) (import devices)
    );
}
