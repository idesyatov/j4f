# nix-channel --add https://nixos.org/channels/nixos-20.09 nixos
# nix-channel --add https://nixos.org/channels/nixos-20.09-small nixos-small
# nix-channel --update


{ config, pkgs, ... }:

let
  nixos-small = import <nixos-small> {};
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./desktop.nix
    ];

  time.timeZone = "Europe/Moscow";
  
  # Sound card state
  sound.enable = true;

  ## LOCALIZATION
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  ## NETWORK
  networking = {
    useDHCP = false;
    networkmanager.enable = true;
    interfaces.enp0s3 = {
      useDHCP = true;
    };
    hostName = "nixos"; # Define your hostname.
  };

  #### Systemd ####
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable NTP deamon.
  services.ntp.enable = true;

  # Stop job timeout.
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  services.journald.rateLimitBurst = 1000;
  services.journald.rateLimitInterval = 10s;

  # SWAPFILE 
  swapDevices = [
    { device = "/var/swapfile";
      size = 8192; # MiB
    }
  ];
 
  ## BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmpOnTmpfs = true;

  ## USERS
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.root.shell = pkgs.zsh;
  users.users.morph = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  ## NIXOS
  system.stateVersion = "20.09"; # Did you read the comment?

  ## Autoclean
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
}
