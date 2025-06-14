[
  {
    name = "poco";
    ip = "192.168.1.11";
    domain = "poco.bryceh.com";
    sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBqkOs8CGx0oibgYIZ68QDp17xl97rnWlCPf7G8CZQwx equi@poco";
    sshKey = "~/.ssh/poco";
    system = "x86_64-linux";
    configuration = ./poco/configuration.nix;
  }
]
