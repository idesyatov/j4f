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
      ./home-manager.nix
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

  ## Systemd ##
  ## Stop job timeout.
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  services.journald.rateLimitBurst = 1000;
  services.journald.rateLimitInterval = "10s";

  ## Services
  services.ntp.enable = true;
  services.openssh.enable = true;

  ## SWAPFILE 
  swapDevices = [
    { device = "/var/swapfile";
      size = 8192; # MiB
    }
  ];
 
  ## BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmpOnTmpfs = true;

  ## Shell params
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

      # Customize your oh-my-zsh options here
      ZSH_THEME="gentoo"
      plugins=(git docker sudo colored-man-pages colorize)

      bindkey '\e[5~' history-beginning-search-backward
      bindkey '\e[6~' history-beginning-search-forward

      HISTFILESIZE=10000
      HISTSIZE=10000
      setopt SHARE_HISTORY
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_DUPS
      setopt INC_APPEND_HISTORY
      autoload -U compinit && compinit
      unsetopt menu_complete
      setopt completealiases

      if [ -f ~/.aliases ]; then
        source ~/.aliases
      fi

      source $ZSH/oh-my-zsh.sh
    '';
    promptInit = "";
  };

  ## USERS
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.root.shell = pkgs.zsh;
  users.users.morph = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ 
      "wheel"
      "video" 
    ]; # Enable ‘sudo’ for the user.
  };

  ## NIXOS
  system.stateVersion = "20.09"; # Did you read the comment?

  nix = {
    trustedUsers = [ "root" ];
    ## Autoclean
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
