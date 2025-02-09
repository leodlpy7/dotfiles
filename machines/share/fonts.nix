{
  pkgs,
  config,
  ...
}: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.symbols-only
    arkpandora_ttf
  ];

  environment.systemPackages = [
    pkgs.adwaita-icon-theme
  ];
}