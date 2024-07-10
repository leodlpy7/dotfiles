{ config, pkgs, ... }:

{
  home.stateVersion = "18.09";
  home.username = "leo";
  home.homeDirectory = "/home/leo";

  # import other config files
  imports = [
    ./waybar.nix
    ./programs/starship.nix
    ./programs/wlogout.nix

    ./programs/hyprland.nix
    ./programs/hyprlock.nix
    ./services/hypridle.nix
    ./services/hyprpaper.nix
  ];

  # home packages
  home.packages = [
    pkgs.discord
    pkgs.sl
    # pkgs.jetbrains.idea-ultimate
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    pkgs.xournalpp
  ];

  # neovim
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.withPython3 = true;
  programs.neovim.viAlias = true;

  # home manager
  programs.home-manager.enable = true;

  # rofi
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  # git
  programs.git = {
    enable = true;
    userName = "Leonard Delpy";
    userEmail = "leonard.delpy@gmail.com";
  };

  # gtk configuration
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.materia-theme;
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "adwaita-icon-theme";
    };
  };

  # config files
  home.file = {
    # kitty config
    ".config/kitty".source = ../config/kitty;

    # fish config
    ".config/fish" = {
      source = ../config/fish;
      recursive = true;
    };

    # rofi config
    ".config/rofi" = {
      source = ../config/rofi;
      recursive = true;
    };
  };
}
