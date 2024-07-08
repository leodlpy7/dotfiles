{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprpaper
  ];

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
}
