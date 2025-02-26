{
  pkgs,
  config,
  ...
}: {
  stylix.targets.swaylock.enable = true;
  
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
      daemonize = true;
      show-failed-attempts = true;
      font = "Inter";
      indicator-radius = 100;
      indicator-thickness = 10;
      grace = 0;
      grace-no-touch = true;
      ignore-empty-password = true;
    };
  };
}
