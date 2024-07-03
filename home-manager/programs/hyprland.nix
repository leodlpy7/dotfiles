{ config, pkgs, ... }:

let
  opacity = "dd";
  active_color = "b117c3";
  inactive_color = "595959";

  wallpaper_path = "~/dotfiles/wallpapers/anime-night-sky.png"; # set wallpaper image
in {
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "de";
      follow_mouse = 1;
      touch_pad.natural_scroll = "yes";
      sensitivity = 0;
    };

    general = {
      gaps_in = 2;
      gaps_out = 4;
      border_size = 2;
      "col.active_border" = "rgba(${active_color}${opacity})";
      "col.inactive_border" = "rgba(${inactive_color}${opacity})";
      layout = "dwindle";
      allow_tearing = false;
    };

    decoration = {
      rounding = 3;
      blur = {
        enabled = true;
	size = 3;
	passes = 1;
      };
      drop_shadow = "yes";
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
    };

    dwindle = {
      pseudotitle = "yes";
      preserve_split = "yes";
    };

    gestures.workspace_swipe = "off";
    misc.force_default_wallpaper = -1;

    workspace = "name:special:btop, gapsout:4, on-created-empty:kitty -e btop";

    # bindings

    "$mainMod" = "SUPER";

    bind = [
      "$mainMod, Return, exec, kitty"
      "$mainMod, Q, killactive,"
      "$mainMod, V, togglefloating,"
      "$mainMod, R, exec, rofi -show drun"
      "$mainMod, P, pseudo," # dwindle
      "$mainMod, J, togglesplit," # dwindle
      "$mainMod, W, exec, firefox"
      "$mainMod, T, exec. thunar"
      "$mainMod, F, fullscreen, 1"
      "$mainMod SHIFT, F, fullscreen,"
      "$mainMod ALT, L, exec, loginctl lock-session"
      "$mainMod, M, exec, wlogout"

      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      "$mainMod SHIFT, left, movewindow, l"
      "$mainMod SHIFT, right, movewindow, r"
      "$mainMod SHIFT, up, movewindow, u"
      "$mainMod SHIFT, down, movewindow, d"

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

      "$mainMod, B, togglespecialworkspace, btop"
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
}
