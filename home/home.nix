{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./desktop/hypr/config.nix
    ./desktop/hypr/wallpaper.nix
    ./desktop/waybar/config.nix

    ./services/default.nix

    ./services/fastfetch/fastfetch.nix
    ./services/rofi/config.nix
    
    ./services/btop.nix
    ./services/fish.nix
    ./services/git.nix
    ./services/kitty.nix
    ./services/minecraft.nix
    ./services/starship.nix
    ./services/swayidle.nix
    ./services/swaylock.nix
    ./services/zathura.nix
  ];

  home.stateVersion = "18.09";
  home.username = "lucysue";
  home.homeDirectory = "/home/lucysue";

  # home manager
  programs.home-manager.enable = true;
  xdg.stateHome = /home/lucysue/.local/state;
}
