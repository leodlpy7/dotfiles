{
  pkgs,
  config,
  inputs,
  ...
}: {
  # allow unfree software in system config
  nixpkgs.config.allowUnfree = true;

  # system programs
  # firefox
  programs.firefox.enable = true;

  # thunar file manager
  # programs.thunar.enable = true;
  # programs.thunar.plugins = with pkgs.xfce; [
  #   thunar-archive-plugin
  #   thunar-volman
  # ];
  services.gvfs.enable = true;

  # fish shell
  programs.fish.enable = true;
  # set default shell
  users.defaultUserShell = pkgs.fish;

  # nixos cli helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 10";
    flake = "/home/lucysue/.dotfiles";
  };

  # Packages installed to the system profile
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    kitty
    waybar
    git
    eza
    ripgrep
    wl-clipboard
    home-manager
    brightnessctl
    (python312.withPackages (python-pkgs: [python-pkgs.requests]))
    texliveFull
    spotify
    dbus
    tlp
    signal-desktop
    thunderbird

    inputs.iio-hyprland.packages.${pkgs.system}.default
    jq

    loupe
    nautilus

    obsidian

    swayidle
    swaylock-effects
    swww

    libsForQt5.qt5ct
    dracula-theme
    nix-output-monitor
    btop
    starship
    # java and intellij
    jdk
  ];
}
