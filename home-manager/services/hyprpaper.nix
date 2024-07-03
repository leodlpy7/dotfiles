{ config, pkgs, ... }:

let
  wallpaper_path = "~/dotfiles/wallpapers/anime-night-sky"; # set wallpaper image here
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${wallpaper_path}"
      ];

      wallpapers = [
        "eDP-1,${wallpaper_path}"
	"HDMI-1,${wallpaper_path}"
      ];

      splash = false;
    };
  };
}
