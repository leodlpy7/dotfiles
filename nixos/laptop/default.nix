{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
    ];

  # experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  networking.hostName = "notnixos";
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  console.keyMap = "de";

  # user config
  users.users.leo = {
    isNormalUser = true;  
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    shell = pkgs.fish;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.support32Bit = true;

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  networking.wireless.userControlled.enable = true;

  system.stateVersion = "23.11";
}
