
# dotfiles - NixOS configuration

This is the nixos configuration for my systems. I am using a flake to manage multiple devices, but by now, there is only my laptop with hostname `amaterasu` registered.

## ToDo's

- [ ] modify waybar config
  - [ ] add music player
  - [x] change to nix
  - [x] change appearance
- [ ] config files to nix config
  - [x] hyprland
  - [ ] fish
  - [x] starship
  - [ ] kitty
  - [x] waybar
  - [ ] rofi
- [x] restructure nix configuration
- [x] put background into dotfiles
- [x] swaylock/swayidle to hyprlock
- [x] gtk config
- [ ] qt config

## Packages

I use this packages (the list does not assume to be complete):

- `blueman`
- `btop`
- `discord`
- `eza`
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

The background wallpaper is now inside the configuration, but unfortunately, `greetd` requires the background to be in `/etc/greetd/`. To use this configuration, you have to copy the background to `/etc/greetd/` to make `greetd` look pleasantly.

## Keyboard shortcuts

| Shortcut                  | Description                                  |
|---------------------------|----------------------------------------------|
| `SUPER Return`            | execute `kitty`, the terminal emulator I use |
| `SUPER Q`                 | kill active window                           |
| `SUPEP V`                 | toggle floating                              |
| `SUPER R`                 | execute `rofi`                               |
| `Super W`                 | execute `firefox` to search the web          |
| `SUPER T`                 | execute `thunar`, the file manager           |
| `SUPER F`                 | maximize active window                       |
| `SUPER SHIFT F`           | make active window fullscreen                |
| `SUPER ALT L`             | lock the screen                              |
| `SUPER M`                 | open logout menu                             |
| `SUPER B`                 | open `btop` in special workspace             |
|                           |                                              |
| `SUPER LEFT ARROW`        | move windows focus left                      |
| `SUPER RIGHT ARROW`       | move windows focus right                     |
| `SUPER UP ARROW`          | move windows focus up                        |
| `SUPER DOWN ARROW`        | move windows focus down                      |
|                           |                                              |
| `SUPER SHIFT LEFT ARROW`  | move active window left                      |
| `SUPER SHIFT RIGHT ARROW` | move active window right                     |
| `SUPER SHIFT UP ARROW`    | move active window up                        |
| `SUPER SHIFT DOWN ARROW`  | move active window down                      |
|                           |                                              |
| `SUPER 1`                 | go to workspace 1                            |
| ...                       | ...                                          |
| `SUPER 9`                 | go to workspace 9                            |
| `SUPER 0`                 | go to workspace 10                           |
|                           |                                              |
| `SUPER SHIFT 1`           | move active window to workspace 1            |
| ...                       | ...                                          |
| `SUPER SHIFT 9`           | move active window to workspace 9            |
| `SUPER SHIFT 0`           | move active window to workspace 10           |
|                           |                                              |
| `FN F2`                   | decrease display brightness                  |
| `FN F3`                   | increade display brigthness                  |
|                           |                                              |
| `FN F7`                   | decrease volume                              |
| `FN F8`                   | increase volume                              |
| `FN F9`                   | toggle mute audio                            |

## Structure of nix configuration

```bash
.
├── config
│  ├── fish
│  │  ├── functions
│  │  │  └── fish_greeting.fish
│  │  └── config.fish
│  ├── hypr
│  │  ├── binds.conf
│  │  ├── hypridle.conf
│  │  ├── hyprland.conf
│  │  ├── hyprlock.conf
│  │  ├── hyprpaper.conf
│  │  └── workspaces.conf
│  ├── kitty
│  │  └── kitty.conf
│  └── rofi
│     ├── themes
│     │  └── catppuccin-macchiato.rasi
│     └── config.rasi
├── home-manager
│  ├── programs
│  │  ├── hyprland.nix
│  │  ├── hyprlock.nix
│  │  └── starship.nix
│  ├── services
│  │  ├── hypridle.nix
│  │  └── hyprpaper.nix
│  ├── home.nix
│  └── waybar.nix
├── keys
│  ├── hosts
│  │  └── host-ssh-key.asc
│  └── users
│     └── id_rsa.gpg
├── machines
│  ├── amaterasu
│  │  ├── default.nix
│  │  └── hardware-configuration.nix
│  └── share
│     ├── hyprland.nix
│     ├── programs.nix
│     ├── security.nix
│     ├── services.nix
│     ├── vars.nix
│     └── wifi.nix
├── secrets
│  └── wifi
├── wallpapers
│  ├── anime-night-sky.png
│  ├── digital-forrest-aurora.png
│  └── digital_forrest.jpg
├── flake.lock
├── flake.nix
└── README.md
```

