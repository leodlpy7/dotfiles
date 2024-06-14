{ config, pkgs, inputs, ... }:
let
  sharedModules = builtins.fromJSON (builtins.readFile ../../config/waybar/config.json);
in {
  home.file = {
    ".config/waybar/style.css".source = ../../config/waybar/style.css;
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        mod = "dock";
        modules-center = [];
        modules-left = [
	  # next to come: playerctl with back/play/pause/forward and artist/title
	  "pulseaudio"
	  "pulseaudio#microphone"
        ];
        modules-right = [
	  "tray"
	  "hyprland/workspaces"
          "cpu"
          "temperature"
          "memory"
          "battery"
	  "network"
	  "clock"
        ];
      }
      // sharedModules;
    };
  };
}
