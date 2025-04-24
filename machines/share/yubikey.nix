{
  pkgs,
  config,
  ...
}:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  environment.systemPackages = [ pkgs.pam_u2f ];

  security.pam.services = {
    login.text = ''
      auth required pam_unix.so
      auth required ${pkgs.pam_u2f}/lib/security/pam_u2f.so cue
      account required pam_unix.so
      session required pam_unix.so
    '';
    sudo.text = ''
      auth required pam_unix.so
      auth required ${pkgs.pam_u2f}/lib/security/pam_u2f.so cue
      account required pam_unix.so
      session required pam_unix.so
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
}
