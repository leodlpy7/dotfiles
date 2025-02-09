{
  pkgs,
  config,
  ...
}: {
  programs.kitty = {
    # use kitty as terminal emulator
    enable = true;
    # font settings
    font = {
      name = "Symbols Nerd Font";
      size = 10;
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
      # close without confirmation
      confirm_os_window_close = 0;
      # basic colors
      foreground = "#cdd6f4";
      background = "#242222";
      selection_foreground = "#1e1e2e";
      selection_background = "#f5e0dc";
      # cursor colors
      cursor = "#f5e0dc";
      cursor_text_color = "#1e1e2e";
      # url color
      url_color = "#f5e0dc";
      # opacity
      background_opacity = "0.75";
      dynamic_background_opacity = "yes";
    };
  };
}
