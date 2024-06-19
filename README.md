
# dotfiles - NixOS configuration

This is the nixOS configuration on my machine.

## ToDo's

- [ ] modify waybar config
  - [ ] add music player
  - [x] change to nix
  - [x] change appearance
- [ ] config files to nix config
  - [ ] hyprland
  - [ ] fish
  - [ ] starship
  - [ ] kitty
  - [x] waybar
- [ ] restructure nix configuration
- [x] put background into dotfiles
- [x] swaylock/swayidle to hyprlock
- [x] gtk config
- [ ] qt config

## Packages

I use this packages (the list does not assume to be complete):

- `blueman`
- `btop`
- `discord`
- `firefox`
- `fish`
- `git`
- `greetd`
- `hypr`
  - `hyprland`
  - `hyprlock`
  - `hypridle`
  - `hyprpaper`
- `intellij`
- `jdk`
- `kitty`
- `nvim`
- `regreet`
- `rofi`
- `spotify`
- `thunar`

## Background wallpaper

The background wallpaper is now inside the configuration, but unfortunately, greetd requires the background to be in `/etc/greetd/`. To use this configuration, you have to copy the background to `/etc/greetd/` to make greetd look pleasantly.
