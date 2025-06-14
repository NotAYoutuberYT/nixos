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
          hostname = d.ip;

          # deploy-rs has a delightful way to include multiple deployments on one node.
          # I don't use this functionality because I get full control of the devices
          # (without any magic), I avoid vendor lock-in with deploy-rs, and my home-rolled
          # service management is more than good enough for me.
          profiles.system = {
            user = "root";
            sshUser = "root";

            sshOpts = [
              "-i"
              d.sshKey
            ];

            path = inputs.deploy-rs.lib.${d.system}.activate.nixos (
              lib.nixosSystem {
                specialArgs = { inherit inputs outputs lib; };

                modules = [
                  outputs.nixosModules.server
                  (import ./service-layout.nix)
                  { config.specialConfig.hosting.device = d; }
                  { config.specialConfig.hosting.devices = import devices; }
                  { imports = d.imports; }
                ];
              }
            );
          };
        };
      }) (import devices)
    );
}
