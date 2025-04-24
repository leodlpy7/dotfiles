{
  lib,
  pkgs,
  config,
  ...
}:
let
  wlinhibit-script = pkgs.writeScriptBin "wlinhibit.sh" ''
    if pidof wlinhibit &> /dev/null; then
      echo '{"text":""}'
    else
      echo '{"text":"", "class":"deactivated"}'
    fi
  '';

  sharedModules = pkgs.writeText "waybar-modules.json" (
    builtins.toJSON {
      backlight = {
	device = "intel_backlight";
	format = "{icon} {percent}%";
	format-icons = [
	  ""
	  ""
	];
	min-length = 6;
	on-scroll-down = "brightnessctl set 1%-";
	on-scroll-up = "brightnessctl set 1%+";
      };
    
      battery = {
	format = "{icon} {capacity}%";
	format-alt = "{time} {icon}";
	format-charging = " {capacity}%";
	format-icons = [
	  ""
	  ""
	  ""
	  ""
	  ""
	];
	format-plugged = " {capacity}%";
	states = {
	  critical = 20;
	  good = 95;
	  warning = 30;
	};
      };
    
      clock = {
	format = "  {:%R %d/%m}";
	tooltip-format = "";
      };
    
      cpu = {
	format = " {usage:>2}%";
	interval = 5;
	states = {
          medium = 20;
          high = 60;
        };
      };
      
      "hyprland/workspaces" = {
	format = "{icon}";
	on-click = "activate";
	format-icons = {
	  "1" = "1";
	  "2" = "2";
	  "3" = "3";
	  "4" = "4";
	  "5" = "5";
	  "urgent" = "";
	  "active" = "";
	};
	sort-by-number = true;
	active-only = false;
	all-outputs = false;
      };
    
      network = {
	format = "{ifname}";
	format-disconnected = "offline";
	format-ethernet = " 󰈀 ";
	format-wifi = " {essid}";
      };
      
      bluetooth = {
        format = "";
        format-disabled = "󰂲";
        format-connected = " {num_connections} connected";
        tooltip-format = "{controller_alias}: {controller_address}";
        tooltip-format-connected = "{controller_alias}: {controller_address}\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}: {device_address}";
        on-click = "${pkgs.tlp}/bin/bluetooth toggle";
      };

      wireplumber = {
        tooltip = false;
        format = "{icon} {volume}%";
        format-muted = "󰝟 <span strikethrough='true'>{volume}%</span>";
        format-icons = [
          ""
          ""
          ""
        ];
        on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        states = {
          high = 100;
        };
      };
      
      temperature = {
	critical-threshold = 80;
	format = " {temperatureC}°C";
	format-critical = " {temperatureC}°C";
	hwmon-path = [
	  "/sys/class/hwmon/hwmon2/temp1_input"
	  "/sys/class/thermal/thermal_zone0/temp"
	];
	thermal-zone = 2;
      };
      
      "custom/wlinhibit" = {
        tooltip = false;
        exec = "${wlinhibit-script}/bin/wlinhibit.sh";
        return-type = "json";
        restart-interval = 3;
        on-click = "killall wlinhibit || ${pkgs.wlinhibit}/bin/wlinhibit";
      };
    }
  );
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = lib.mkForce ./style.css;

    settings.mainBar = {
      include = sharedModules;
      mod = "dock";
      margin-top = 3;
      modules-center = [];
      modules-left = [
	"backlight"
	"wireplumber"
	"custom/wlinhibit"
	"hyprland/workspaces"
      ];
      modules-right = [
        "cpu"
        "temperature"
        "battery"
	"bluetooth"
	"network"
	"clock"
      ];
      height = 10;
      layer = "top";
      position = "top";
    };
  };
}
