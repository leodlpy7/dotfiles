{ config, pkgs, ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances
	before_sleep_cmd = "loginctl lock-session";
	after_sleep_cmd = "hyprctl dispatch dpms on"; # tp avoid having to press a key twice to turn on the display
      };

      listener = [
        {
	  timeout = 150;
	  on-timeout = "brightnessctl -s set 10";
	  on-resume = "brightnessctl -r";
	}
	{
	  timeout = 300;
	  on-timeout = "loginctl lock-session";
	}
	{
	  timeout = 330;
	  on-timeout = "hyprctl dispatch dpms off";
	  on-resume = "hyprctl dispatch dmps on";
	}
	{
	  timeout = 1800;
	  on-timeout = "systemctl suspend";
	}
      ];
    };
  };
}
