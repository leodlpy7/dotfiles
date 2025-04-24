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

  services.udev.packages = [ pkgs.yubikey-personalization ];

  # gpg for security
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # modify pam stacks for 2fa
  security.pam.services =
    let
      pamStack = ''
        auth required pam_unix.so
        auth required ${pkgs.pam_u2f}/lib/security/pam_u2f.so cue
        account required pam_unix.so
        session required pam_unix.so
      '';
    in
    {
      login.text = pamStack;
      sudo.text = pamStack;
      su.text = pamStack;
      swaylock.text = ''
        auth include login
      '';
      greetd.text = ''
        auth include login
      '';
    };

  security.pam.u2f = {
    enable = true;
  };

  security.pam.yubico = {
    enable = true;
    debug = true;
    mode = "challenge-response";
    id = [ "33038951" ];
  };

  # lock session if yubikey is unplugged
  services.udev.extraRules = ''
    ACTION=="remove",\
     ENV{ID_BUS}=="usb",\
     ENV{ID_MODEL_ID}=="0407",\
     ENV{ID_VENDOR_ID}=="1050",\
     ENV{ID_VENDOR}=="Yubico",\
     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';

  # greetd
  programs.regreet = {
    enable = true;
    settings = {
      background.fit = lib.mkForce "Fill";

      env = { };
    };
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
