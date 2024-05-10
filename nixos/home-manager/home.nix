{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
    "../../config/hyprland/hyprland.conf"
  ];

  home-manager.users.leo ={
    home.stateVersion = "18.09";
    home.username = "leo";
    home.homeDirectory = "/home/leo";

    # home packages
    home.packages = [
      pkgs.noto-fonts
        pkgs.noto-fonts-emoji
        (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];

    # rofi
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    # home manager
    programs.home-manager.enable = true;

    # git
    programs.git = {
      enable = true;
      userName = "Leonard Delpy";
      userEmail = "leonard.delpy@gmail.com";
    };
  };
}
