{ config, pkgs, inputs, ... }:
let
  opacity = "0";
  fontSize = "14";
  iconSize = "16";
  palette = {
    font = "Symbols Nerd fonts, monospace";
    fontsize = fontSize;
    iconsize = iconSize;
    primary_accent = "cba6f7";
    secondary_accent = "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "282c34";

    primary_accent_hex = "cba6f7";
    secondary_accent_hex = "89b4fa";
    tertiary_accent_hex = "f5f5f5";
    primary_background_hex = "11111B";
    secondary_background_hex = "1b1b2b";
    tertiary_background_hex = "21252b";

    primary_accent_rgba = "rgba(203, 166, 247, ${opacity})";
    secondary_accent_rgba = "rgba(137, 180, 250, ${opacity})";
    tertiary_accent_rgba = "rgba(245, 245, 245, ${opacity})";
    primary_background_rgba = "rgba(40, 44, 52, ${opacity})";
    secondary_background_rgba = "rgba(59, 63, 76, ${opacity})";
    tertiary_background_rgba = "rgba(33, 37, 43, ${opacity})";

    critical = "rgba(255, 0, 0, ${opacity})";
  };
in {
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      mod = "dock";
      # set margins
      margin-top = 0;
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      # module used in waybar
      modules-left = [
        # next to come: playerctl with back/play/pause/forward and artist/title
        "pulseaudio"
        "pulseaudio#microphone"
	"backlight"
        "tray"
      ];
      modules-center = [
        "hyprland/workspaces"
      ];
      modules-right = [
        "cpu"
        "temperature"
        "memory"
        "battery"
        "network"
        "clock"
      ];
      # add music player settings later
      # pulseaudio settings
      pulseaudio = {
        format = "{icon} {volume}%";
        format-icons = {
          car = "";
          default = ["" "" ""];
          hands-free = "";
          headphone = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " Muted";
        on-click = "pamixer -t";
        on-scroll-down = "pamixer -d 5";
        on-scroll-up = "pamixer -i 5";
        scroll-step = 5;
        # tooltip = false;
      };
      # pulseaudio microphone settings
      "pulseaudio#microphone" = {
        format = "{format_source}";
        format-source = " {volume}%";
        format-source-muted = "  Muted";
        on-click = "pamixer --default-source -t";
        on-scroll-down = "pamixer --default-source -d 5";
        on-scroll-up = "pamixer --default-source -i 5";
        scroll-step = 5;
      };
      # backlight settings
      backlight = {
        device = "intel_backlight";
        format = "{icon} {percent}%";
        format-icons = ["" ""];
        min-length = 6;
        on-scroll-down = "brightnessctl set 1%-";
        on-scroll-up = "brightnessctl set 1%+";
      };
      # tray settings
      tray = {
        icon-size = palette.iconsize;
        spacing = 10;
      };
      # hyprland workspace settings
      "hyprland/workspaces" = {
        active-only = false;
        all-outputs = true;
        disable-scroll = true;
        format = "{name}";
        on-click = "activate";
        format-icons = {
          urgent = "";
          active = "";
          default = "";
          sort-by-number = true;
        };
      };
      # hyprland window settings
      "hyprland/window" = {
        format = "<span font=${palette.fontsize} rise='-4444'>{}</span>";
        max-length = 200;
        separate-outputs = true;
      };
      # cpu settings
      cpu = {
        format = "{usage:>2}%";
        interval = 1;
      };
      # temperature settings
      temperature = {
        format = " {temperatureC}°C";
        format-critical = "<span foreground=${palette.critical}> {temperatureC}°C</span>";
        critical-threshold = 60;
        hwmon-path = [
          "/sys/class/hwmon/hwmon2/temp1_input"
          "/sys/class/thermal/thermal_zone0/temp"
        ];
        thermal-zone = 2;
      };
      # memory settings
      memory = {
        format = " {used:0.1f}G/{total:0.1f}G";
        interval = 30;
      };
      # battery settings
      battery = {
        format = "{icon} {capacity}%";
        format-alt = "{time} {icon}";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = ["" "" "" "" ""];
        states = {
	  good = 95;
	  warning = 25;
	  critical = 15;
	};
      };
      # network settings
      network = {
        format-wifi = " {signalStrength}%";
        format-ethernet = "󰈀 ";
        tooltip-format = " {essid} ({signalStrength}%)";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "󰖪 ";
      };
      # clock settings
      clock = {
        format = " {:%R  %d.%m.}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	tooltip = true;
      };
    };
    # styling
    style = ''
      * {
        border: none;
        border-radius: 0px;
        font-family: ${palette.font};
        font-size: ${palette.fontsize};
        min-height: 0;
      }

      window#waybar {
         background: ${palette.primary_background_rgba};
	 color: #${palette.primary_accent};
      }

      tooltip {
        background: #${palette.primary_background_hex};
	border-radius: 10px;
	border-width: 2px;
	border-style: solid;
	border-color: #${palette.secondary_background_hex};
      }

      #pulseaudio, #backlight, #tray {
        color: #${palette.tertiary_accent};
	background: #${palette.tertiary_background_hex};
	font-weight: bold;
	margin: 5px 0px;
	border-radius: 24px 10px 24px 10px;
	padding: 0 20px;
	margin-left: 7px;
      }

      #workspaces {
        background: #${palette.tertiary_background_hex};
        border-radius: 16px;
	margin: 5px 5px;
	padding: 8px 5px;
        color: #${palette.primary_accent};
      }
	  
      #workspaces button {
        padding: 0px 5px;
        margin: 5px 3px;
        border-radius: 16px;
        background: ${palette.primary_background_rgba};
	transition: all 0.3s ease-in-out;
      }

      #workspaces button.active {
        background-color: #${palette.secondary_accent};
        color: #${palette.background};
        border-radius: 16px;
	transition: all 0.3s ease-in-out;
      }

      #workspaces button:hover {
        background-color: #${palette.tertiary_accent};
        color: #${palette.background};
        border-radius: 16px;
      }

      #network, #battery, #cpu, #memory, #temperature {
        color: #${palette.tertiary_accent};
        background: #${palette.tertiary_background_hex};
        font-weight: bold;
        margin: 5px 0px;
        border-radius: 10px 24px 10px 24px;
        padding: 0 20px;
        margin-left: 7px;
      }

      #clock {
        color: #${palette.tertiary_accent};
        background: #${palette.tertiary_background_hex};
        border-radius: 0px 0px 0px 40px;
        padding: 10px 10px 15px 25px;
        margin-left: 7px;
        font-weight: bold;
        font-size: ${palette.fontsize};
      }
    '';
  };
}
