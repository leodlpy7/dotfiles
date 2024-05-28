{ config, pkgs, ... }:

{
  # security related pkgs
  environment.systemPackages = with pkgs; [
    swayidle
    swaylock-effects
  ];

  # important to allow swaylock to verify pwd
  security.pam.services.swaylock = {
    text = ''
      auth sufficient pam_fprintd.so
      auth include login
      '';
  };
}
