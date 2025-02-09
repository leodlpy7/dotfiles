{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.kitty = {
    # use kitty as terminal emulator
    enable = true;
    # font settings
    font = {
      name = lib.mkForce "Symbols Nerd Font";
      size = lib.mkForce 10;
    };
    # use fish inside kitty
    shellIntegration.enableFishIntegration = true;
    # custom key bindings
    keybindings = {
      "ctrl+plus" = "change_font_size all +1.0";
      "ctrl+minus" = "change_font_size all -1.0";
    };
    # additional settings
    settings = {
      confirm_os_window_close = 0;
      background_opacity = lib.mkForce "0.75";
      dynamic_background_opacity = "yes";
    };
  };
}
