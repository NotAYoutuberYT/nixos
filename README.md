# Personal NixOS Configuration

## Initial Setup for Desktop

Setup *should* be painless. Feel free to install NixOS headless.

1. Clone this repository (`nix run --extra-experimental-features 'nix-command flakes' nixpkgs#git -- clone https://github.com/NotAYoutuberYT/nixos`)
1. Create a new host as needed (copy a pre-existing host, move hardware-configuration into new host, edit configuration.nix and home.nix, etc.)
1. Rebuild and reboot (`sudo nixos-rebuild boot --flake /path/to/flake#hostname`)
1. Sync secrets, logins, and such (sops-nix key is a good starting point; also consider ssh keys and git authentication)

## Initial Setup for Servers

1. Boot into the headless nixos installer, run `passwd`, and type `temp` twice (no monitor required!) or
simply setup SSH into root on an existing device
1. Create a new host and deploy-rs node as needed (this probably just involves copying an existing config and switching around services)
1. Deploy remotely with nixos-anywhere (this may involve temporarily hardcoding secrets)
1. SSH into the device and copy over the sops-nix key
1. Deploy with deploy-rs (if you had to hardcode secrets)
1. Profit

## TODO

- add more stuff and change things around (I have an external list for this)
- get a better solution for defining networks and desktop options
- improve modularity
    - make things such as notification daemons, terminals, editors, compositors, and shells a bit more modular
    - it should be trivial to swap between sway/hyprland/niri/dwm, alacritty/kitty/wezterm, rofi/dmenu, etc.
- get a proper widget system (make sure it can be swapped in/out for external solutions)
- allow for multiple users and generaly handle users better (remember to allow stylix overrides!)
- provide type information for all custom options
