{ config, pkgs, ... }:

{
  programs.starship.enable = true;
  programs.starship.settings = {
    character = {
      success_symbol = "➜";
      error_symbol = "➜";
    };
  };
}
