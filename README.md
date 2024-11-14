## TODO

- properly rice hyprland & apps using [nix-colors](https://github.com/Misterio77/nix-colors)
    - some pre-written rices can be found using [stylix](https://github.com/danth/stylix/tree/master/modules)
    - [hyprland](https://wiki.hyprland.org/0.41.2/Configuring/Variables/)
    - [lf](https://github.com/gokcehan/lf/blob/master/etc/colors.example)
    - [rofi](https://github.com/davatorium/rofi/blob/next/doc/rofi-theme.5.markdown)
    - maybe get a better wallpaper in the process
- add a widget system
    - astal should be coming out relatively soon...
    - find a way to pass nixos parameters (most importantly monitor names) into a widget configuration
- improve modularity of various things
    - make swapping in/out fonts easier
    - make swapping in/out cursors easier
    - only configure programs for use in hyprland if those programs are enabled
- fix steam on desktop
- get (and configure?) vesktop
- declaratively manage firefox toolbar and bookmarks
- don't assume hyprland is the active compositor for autologin

## Initial Setup

- Clone this repository (`nix run --extra-experimental-features 'nix-command' nixpkgs#git -- clone https://github.com/NotAYoutuberYT/nixos`)
- Create a new host as needed (copy a pre-existing host, move hardware-configuration into new host, edit configuration.nix and home.nix as needed)
- Rebuild and reboot (`nixos-rebuild boot --flake /path/to/flake#hostname`)
- Configure system (optional)
    - Copy secret keys (password manager, ssh, etc.) from another machine
    - Use gh to authenticate with github (`gh auth login`) *after* copying password manager files
    - Configure firefox bookmarks & toolbar (and link keepassxc to its firefox extension)