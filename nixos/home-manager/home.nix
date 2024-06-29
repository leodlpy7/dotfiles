{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    sha256 = "0hmpljazjk11g2hjs4dgz283k728wvfdaplr3a8ix9chjadk745x";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
    ../share/hypr.nix
    ../share/programs.nix
    ../share/security.nix
    ../share/vars.nix
    ../share/wifi.nix
    ../share/services.nix
  ];

  home-manager.users.leo = {
    home.stateVersion = "18.09";
    home.username = "leo";
    home.homeDirectory = "/home/leo";

    # import other config files
    imports = [
      ./waybar.nix
      ./programs/starship.nix
    ];

    # home packages
    home.packages = [
      pkgs.discord
      pkgs.sl
      # pkgs.jetbrains.idea-ultimate
      pkgs.noto-fonts
      pkgs.noto-fonts-emoji
      (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];

    # neovim
    programs.neovim.enable = true;
    programs.neovim.defaultEditor = true;
    programs.neovim.withPython3 = true;
    programs.neovim.viAlias = true;

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

    # gtk configuration
    gtk = {
      enable = true;
      theme = {
        name = "Dracula";
        package = pkgs.materia-theme;
      };
      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "adwaita-icon-theme";
      };
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

      # rofi config
      ".config/rofi" = {
        source = ../../config/rofi;
	recursive = true;
      };
    };
  };
}
