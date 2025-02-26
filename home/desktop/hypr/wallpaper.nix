{
  pkgs,
  config,
  ...
}:
let
  wallpaper_path = "~/.dotfiles/resources/wallpapers/flowers.jpg"; # set wallpaper image here
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${wallpaper_path}"
      ];

      wallpaper = [
        "eDP-1,${wallpaper_path}"
	      "HDMI-A-1,${wallpaper_path}"
      ];

      splash = false;
    };
  };
}
