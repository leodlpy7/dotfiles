{ config, pkgs, inputs, ... }:
let
  sharedModules = builtins.fromJSON (builtins.readFile ../../config/waybar/config.json);
in {
  home.file = {
    ".config/waybar/style.css".source = ../../config/waybar/style.css;
    ".config/waybar/scripts".source = ../../config/waybar/scripts;
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        mod = "dock";
        modules-center = [];
        modules-left = [
          "clock"
          "custom/weather"
          "hyprland/workspaces"
          "network"
        ];
        modules-right = [
          "tray"
          "cpu"
          "temperature"
          "memory"
          "battery"
          "backlight"
          "pulseaudio"
          "pulseaudio#microphone"
        ];
      };
    };
  };
}
