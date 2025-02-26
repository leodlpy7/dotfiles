{
  lib,
  pkgs,
  config,
  ...
}:
let
  powermenu-script = pkgs.writeScriptBin "powermenu.sh" ''
    dir="$HOME/.config/rofi/"
    theme='powermenu'

    # CMDs
    uptime="`uptime | sed -E 's/^[^,]*up *//; s/, *[[:digit:]]* users.*//; s/min/minutes/; s/([[:digit:]]+):0?([[:digit:]]+)/\1 hours, \2 minutes/' `"
    host=`hostname`

    # Options
    shutdown=''
    reboot=''
    lock=''
    suspend=''
    logout=''
    yes=''
    no=''

    # Rofi CMD
    rofi_cmd() {
      ${pkgs.rofi-wayland}/bin/rofi -dmenu \
        -p "Uptime: $uptime" \
        -mesg "Uptime: $uptime" \
        -theme $dir/$theme.rasi
    }

    # Confirmation CMD
    confirm_cmd() {
      ${pkgs.rofi-wayland}/bin/rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme $dir/$theme.rasi
    }

    # Ask for confirmation
    confirm_exit() {
      echo -e "$yes\n$no" | confirm_cmd
    }

    # Pass variables to rofi dmenu
    run_rofi() {
      echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
    }

    # Execute Command
    run_cmd() {
      selected="$(confirm_exit)"
      if [[ "$selected" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
          systemctl poweroff
        elif [[ $1 == '--reboot' ]]; then
          systemctl reboot
        elif [[ $1 == '--suspend' ]]; then
          systemctl suspend
        elif [[ $1 == '--logout' ]]; then
          ${pkgs.hyprland}/bin/hyprctl dispatch exit
        fi
      else
        exit 0
      fi
    }

    # Actions
    chosen="$(run_rofi)"
    case $chosen in
        $shutdown)
        run_cmd --shutdown
            ;;
        $reboot)
        run_cmd --reboot
            ;;
        $lock)
        ${pkgs.swaylock-effects}/bin/swaylock -C $HOME/.config/swaylock/config
            ;;
        $suspend)
        run_cmd --suspend
            ;;
        $logout)
        run_cmd --logout
            ;;
    esac'';
in {
  home.packages = [
    pkgs.rofi-wayland
    powermenu-script
  ];

  home.file.".config/rofi/config.rasi".text = lib.mkForce (builtins.readFile ./config.rasi);
  home.file.".config/rofi/powermenu.rasi".text = builtins.readFile ./powermenu.rasi;
  home.file.".config/rofi/shared/colors.rasi".text = builtins.readFile ./shared/colors.rasi;
  home.file.".config/rofi/shared/fonts.rasi".text = builtins.readFile ./shared/fonts.rasi;
}