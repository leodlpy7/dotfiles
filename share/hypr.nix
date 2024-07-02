{ config, pkgs, inputs, ... }:

{
  # load packages related to hyprland
  environment.systemPackages = with pkgs; [
    hyprpaper
  ];

  # hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  home-manager.users."leo" = {
    # load config files
    home.file = {
      ".config/hypr/hyprlock.conf".source = ../config/hypr/hyprlock.conf;
      ".config/hypr/hypridle.conf".source = ../config/hypr/hypridle.conf;
    };
  };
}
