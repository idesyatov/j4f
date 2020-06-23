# Software env
{ config, pkgs, ...}:

let
  nonfree = import <nixos> { config.allowUnfree = true; };
in {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim git htop tmux wget 
    tldr tree ranger 

    rxvt_unicode
    # bindsym $mod+c exec "CM_ONESHOT=1 clipmenud"
    # bindsym $mod+v exec clipmenu
    clipmenu
    chromium
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
}