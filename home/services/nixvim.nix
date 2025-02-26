{
  pkgs,
  config,
  ...
}: {
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
  };
}
