{ config, pkgs, ... }:

{
  # allow unfree software in system config
  nixpkgs.config.allowUnfree = true;

  # system programs
  # hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  # firefox
  programs.firefox.enable = true;

  # thunar file manager
  programs.thunar.enable = true;

  # fish shell
  programs.fish.enable = true;
  # set default shell
  users.defaultUserShell = pkgs.fish;

  # Packages installed to the system profile
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    kitty
    rofi-wayland
    waybar
    git
    wl-clipboard
    home-manager
    tree
    brightnessctl
    (python312.withPackages (python-pkgs: [python-pkgs.requests]))
    texliveFull
    hyprpaper
    spotify
  ];
}
