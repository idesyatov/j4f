# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  ## DISK CONFIGURATION
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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

  # Define your hostname
  networking.hostName = "nixos"; # Define your hostname.

  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;

  ## LOCALIZATION

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # utils
    vim
    git
    htop
    tldr
    tmux
    tree
    wget
    ranger
    chromium
    networkmanagerapplet
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  ## SERVICES

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  ## XSERVER

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";

    desktopManager = {
        xterm.enable = false;
    };

    displayManager = {
        defaultSession = "none+i3";
    };

    windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
            dmenu
            i3status
            i3lock
            i3blocks
        ];
    };
  };

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
        anonymousPro
        #corefonts # Microsoft's fonts (unfree)
        dejavu_fonts
        noto-fonts
        freefont_ttf
        google-fonts
        inconsolata
        liberation_ttf
        powerline-fonts
        source-code-pro
        terminus_font
        ttf_bitstream_vera
        ubuntu_font_family
    ];
  };

  ## USERS

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.morph = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  ## NIXOS

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}
