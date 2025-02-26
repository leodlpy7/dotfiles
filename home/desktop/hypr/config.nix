{
  pkgs,
  inputs,
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      # monitor config
      monitor = [
        "eDP-1, preferred, auto, 1, transform, 0"
        "HDMI-A-1, preferred, auto, auto"
      ];

      exec-once = [
        "hyprpaper & iio-hyprland"
        "swayidle -w"
      ];

      # input
      input = {
        kb_layout = "de";
        follow_mouse = 1;
        touchpad.natural_scroll = "yes";
        sensitivity = 0;
      };

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = false;
	resize_on_border = true;
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
	        size = 3;
	        passes = 1;
        };
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures.workspace_swipe = "off";
      misc.force_default_wallpaper = -1;

      # bindings
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Return, exec, ${pkgs.kitty}/bin/kitty"
        "$mainMod, W, exec, ${pkgs.firefox}/bin/firefox"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, B, exec, killall rofi-bluetooth || ${pkgs.rofi-bluetooth}/bin/rofi-bluetooth"
        "$mainMod, Backspace, killactive,"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, J, togglesplit," # dwindle
        "$mainMod, F, fullscreen, 1"
        "$mainMod SHIFT, F, fullscreen,"
        "$mainMod ALT, L, exec, ${pkgs.swaylock-effects}/bin/swaylock -C $HOME/.config/swaylock/config"
        "$mainMod ALT, M, exec, powermenu.sh"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    
      bindl = [
        ", XF86MonBrightnessDown, exec, brightnessctl set 1%-" # fn + f2
        ", XF86MonBrightnessUp, exec, brightnessctl set 1%+" # fn + f3

        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-" # fn + f7
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+" # fn + f8
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # fn + f9
      ];
    };
  };
}
