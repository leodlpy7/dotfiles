{ config, pkgs, ... }:

{
  # make my machine a ssh service
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  # enable sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # bluetooth controller
  services.blueman.enable = true;
}
