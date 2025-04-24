{
  lib,
  pkgs,
  config,
  ...
}:
{
  # security related pkgs
  environment.systemPackages = with pkgs; [
    greetd.regreet
    pinentry-qt
    pam_u2f
    swaylock
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
      auth include login
    '';
  };

  # greetd
  programs.regreet = {
    enable = true;
    settings = {
      background.fit = lib.mkForce "Fill";

      env = { };
    };
  };

  security.pam.services.greetd = {
    text = ''
      auth include login
    '';
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session =
        let
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
        in
        {
          command = "${pkgs.hyprland}/bin/Hyprland --config ${hyprlandConfig}";
        };
    };
  };
}
