{
  lib,
  pkgs,
  config,
  ...
}: {
  # security related pkgs
  environment.systemPackages = with pkgs; [
    greetd.regreet
    pinentry-qt
  ];

  # gpg for security
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # important to allow swaylock to verify pwd
  security.pam.services.swaylock = {
    text = ''
      auth sufficient pam_fprintd.so
      auth include login
    '';
  };

  # greetd
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = "/etc/greetd/background.jpg";
        fit = "Fill";
      };

      env = {};

      GTK = {
        cursor_theme_name = lib.mkForce "Dracula";
        font_name = "Cantarell 16";
        icon_theme_name = lib.mkForce "Dracula";
        theme_name = lib.mkForce "Dracula";
      };
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = let
        hyprlandConfig = builtins.toFile "hyprland.regreet.conf" ''
          exec-once = regreet; hyprctl dispatch exit;
          windowrulev2 = fullscreen, title:^regreet$
          animations {
            enabled = no
          }
          misc {
            disable_hyprland_logo = yes
            disable_splash_rendering = yes
          }
        '';
      in {
         command = "${pkgs.hyprland}/bin/Hyprland --config ${hyprlandConfig}";
      };
    };
  };
}
