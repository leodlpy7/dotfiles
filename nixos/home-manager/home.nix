{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    sha256 = "0sxdrx1chydigqpyg69ix7r61akvh39a0s5g6b3q1770aqkw6hp3";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
    ../share/programs.nix
  ];

  home-manager.users.leo = {
    home.stateVersion = "18.09";
    home.username = "leo";
    home.homeDirectory = "/home/leo";

    # import other config files
    imports = [
      ./waybar.nix
    ];

    # home packages
    home.packages = [
      pkgs.discord
      pkgs.sl
      pkgs.jetbrains.idea-ultimate
      pkgs.noto-fonts
        pkgs.noto-fonts-emoji
        (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];

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

    # config files
    home.file = {
      # hyprland config
      ".config/hypr" = {
        source = ../../config/hypr;
        recursive = true;
      };

      # kitty config
      ".config/kitty".source = ../../config/kitty;

      # fish config
      ".config/fish" = {
        source = ../../config/fish;
	recursive = true;
      };
    };
  };
}
