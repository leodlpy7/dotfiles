{ config, lib, pkgs, ... }:

{
  imports = [
    ../share/vars.nix
    ../share/programs.nix
    ../share/security.nix
    ../share/hypr.nix
    ../share/wifi.nix
    ../share/services.nix
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

  # bluetooth
  hardware.bluetooth.enable = true;

  # do not change
  system.stateVersion = "23.11";
}
