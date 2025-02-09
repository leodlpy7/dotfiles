{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    base16-schemes
  ];

  stylix = {
    enable = true;
    image = ../../resources/wallpapers/simulation_bullet_lightning.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };
}