## TODO

- properly handle dependencies/improve modularity
    - unify the home manager and nixos modules that correspond to the same thing (i.e. hyprland)
    - make things such as notification daemons, terminals a bit more modular
    - this will probably involve slightly reworking hyprland
    - make a "controled" or "modular" directory in home manager modules that doesn't turn into configurable options but is instead *only* controlled by looking at nix options?
- rice hyprland & apps
    - make everything (fonts, cursors, etc.) a bit more modular and configurable
    - get cursors working in X11
    - get a proper file manager
    - some pre-written rices can be found using [stylix](https://github.com/danth/stylix/tree/master/modules)
- configure astal
- get a proper display manager (don't assume hyprland is the active compositor/desktop environment!)
- get proper secret management
    - see [sops-nix](https://github.com/Mic92/sops-nix)
    - I don't really need this right now, but it could be handy (user passwords?)

## Initial Setup

- Clone this repository (`nix run --extra-experimental-features 'nix-command' nixpkgs#git -- clone https://github.com/NotAYoutuberYT/nixos`)
- Create a new host as needed (copy a pre-existing host, move hardware-configuration into new host, edit configuration.nix and home.nix as needed)
- Rebuild and reboot (`nixos-rebuild boot --flake /path/to/flake#hostname`)
- Configure system (optional)
    - Copy secret keys (password manager, ssh, etc.) from another machine
    - Use gh to authenticate with github (`gh auth login`) *after* copying password manager files
    - Link keepassxc to its firefox extension