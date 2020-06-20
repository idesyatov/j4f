# Nixos configuration
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./desktop.nix
    ];

  time.timeZone = "Europe/Moscow";
  
  ## LOCALIZATION
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  #boot.initrd.luks.devices = [
  #  {
  #    name = "luksroot";
  #    device = "/dev/sda2";
  #  }
  #];

  ## NETWORK
  networking.hostName = "nixos"; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Swapfile 
  swapDevices = [
    { device = "/var/swapfile";
      size = 8192; # MiB
    }
  ];

  ## USERS
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.morph = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  ## NIXOS
  system.stateVersion = "20.03"; # Did you read the comment?

  nix.optimise.automatic = true;
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 7d";
}
