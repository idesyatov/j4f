# Software env
{ config, pkgs, ...}:

let
  nonfree = import <nixos> { config.allowUnfree = true; };
in {
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
    #networkmanager
    networkmanagerapplet
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
}