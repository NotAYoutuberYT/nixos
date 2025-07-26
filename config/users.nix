{
  config,
  ...
}:

{
  # TODO: move user configuration to baseNixos.nix
  config = {
    users.mutableUsers = false;
    users.users.${config.specialConfig.username} =
      {
        isNormalUser = true;
        shell = config.specialConfig.shell;
        description = config.specialConfig.username;
        extraGroups = [
          "wheel"
        ];
      }
      // config.specialConfig.passwordAttrset
      // config.specialConfig.extraSettings;
  };
}
