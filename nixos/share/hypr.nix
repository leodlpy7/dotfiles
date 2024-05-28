{ config, pkgs, ... }:

{
  # hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  # hyprlock
  # programs.hyprlock.enable = true;
}
