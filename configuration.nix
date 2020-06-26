# nix-channel --add https://nixos.org/channels/nixos-20.03 nixos
# nix-channel --add https://nixos.org/channels/nixos-unstable unstable
# nix-channel --update


{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
in {
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

  ## NETWORK
  networking = {
    useDHCP = false;
    interfaces.enp0s3 = {
      useDHCP = false;
    };
    hostName = "nixos"; # Define your hostname.
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
