{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    discord
    wlinhibit
    libreoffice-still
    vscodium
    hyprpaper
    hyprland
    zathura
    killall
    grim
    slurp
    pympress
    gcc
    pdfpc
    duf
    element-desktop
    unzip
    dconf
  ];
}