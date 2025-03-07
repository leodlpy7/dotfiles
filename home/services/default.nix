{
  pkgs,
  config,
  inputs,
  system,
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
    inputs.zenbrowser.packages."x86_64-linux".default
  ];
}
