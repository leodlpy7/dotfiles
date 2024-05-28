{ config, pkgs, ... }:

{
  # allow unfree software in system config
  nixpkgs.config.allowUnfree = true;

  # system programs
  # firefox
  programs.firefox.enable = true;

  # thunar file manager
  programs.thunar.enable = true;

  # fish shell
  programs.fish.enable = true;
  # set default shell
  users.defaultUserShell = pkgs.fish;

  # nixos cli helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 10";
    flake = "/home/leo/dotfiles";
  };

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
    hyprlock
    spotify
    wlogout
  ];
}
