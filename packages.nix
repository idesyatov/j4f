# Software env
{ config, pkgs, ...}:

{
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
}