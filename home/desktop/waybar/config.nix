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
      clock = {
        format = "  {:%R %d/%m}";
      };
      
      "hyprland/workspaces" = {
        all-outputs = true;
        format = "{name}";
        sort-by-number = true;
        active-only = false;
      };
      
      "hyprland/submap" = {
        tooltip = false;
        on-click = "${pkgs.hyprland}/bin/hyprctl dispatch submap reset";
      };
      
      cpu = {
        interval = 5;
        format = "";
        states = {
          medium = 20;
          high = 60;
        };
      };
      
      memory = {
        interval = 10;
        format = "";
        states = {
          medium = 40;
          high = 80;
        };
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
      
      battery = {
        format = "{capacity}% {icon}";
        format-charging = "󱐋 {capacity}% {icon}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        states = {
          low = 20;
        };
      };
      
      network = {
        format = "{ifname}";
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = " 󰈁 ";
        format-disconnected = "";
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
      
      backlight = {
        tooltip = false;
        device = "intel_backlight";
        format = "{percent}% {icon}";
        format-icons = [
          ""
          ""
        ];
      };
      
      user = {
        format = "🐢 {work_H}:{work_M}";
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
      modules-left = [
        "backlight"
        "wireplumber"
        "custom/wlinhibit"
        "hyprland/workspaces"
        "hyprland/submap"
      ];
      modules-right = [
        "battery"
        "bluetooth"
        "network"
        "memory"
        "cpu"
        "user"
        "clock"
      ];

      height = 32;
      layer = "top";
      position = "top";
    };
  };
}