# Personal NixOS Configuration

Currently being rewritten. Check in later!

## Notes

- This configuration is built with modularity and extensibility in mind. This config's roots as a copy of Vimjoyer's configuration are still very present, but there are now some structural differences.
- Home manager is purely used for configuration; most home manager package modules are enabled only when a corresponding NixOS module is enabled.
- Version control is in place purely so I can roll back/reference old versions of my system at will. Expect poor commit messages, no branches, etc.

## Initial Setup

Setup *should* be painless. Feel free to install NixOS headless.

1. Clone this repository (`nix run --extra-experimental-features 'nix-command flakes' nixpkgs#git -- clone https://github.com/NotAYoutuberYT/nixos`)
1. Create a new host as needed (copy a pre-existing host, move hardware-configuration into new host, edit configuration.nix and home.nix, etc.)
1. Copy sops-nix keys (and anything else you may need later)
1. Rebuild and reboot (`sudo nixos-rebuild boot --flake /path/to/flake#hostname`)
1. Sync secrets, logins, and such (`gh auth login` is a good starting point)

## TODO

- write configurations for homelab machines
- properly handle dependencies/improve modularity
    - make things such as notification daemons, terminals, editors, compositors, and shells a bit more modular
    - it should be trivial to swap between sway/hyprland, alacritty/kitty, etc.
- improve integration of nix shells with editor
    - configure editor/install extensions from nix shells
    - see [nix-direnv](https://github.com/nix-community/nix-direnv)
    - move to neovim
- ricing!!
    - this goes back to modularity (colors, cursors, etc.)
    - get a proper file manager
    - some pre-written rices can be found using [stylix](https://github.com/danth/stylix/tree/master/modules)
- get a proper widget system
- get a proper display manager (make sure to not break compositor modularity!)
- allow for multiple users (all user configuration is in user.nix, this shouldn't be too hard)
- make git config support multiple profiles
