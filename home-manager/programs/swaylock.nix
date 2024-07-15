{ config, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {
      clock = true;
      indicator = true;
      screenshots = true;
      effect-scale = "0.8";
      effect-vignette = "0.2:0.5";
      effect-blur = "4x2";
      datestr = "%a %e.%m.%Y";
      timestr = "%k:%M";
    };
  };
}
