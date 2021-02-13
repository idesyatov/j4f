# Software env
{ config, pkgs, ...}:

let
  nonfree = import <nixos> { config.allowUnfree = true; };
  unstable = import <unstable> {};
  unstable-nonfree = import <unstable> { config.allowUnfree = true; };
in {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  imports =
  [
    ./nix/zsh.nix
    ./nix/vim.nix
    ./nix/chromium.nix
  ];
  environment.systemPackages = with pkgs; [
    
    # Utils
    git htop tmux wget tldr
    rxvt_unicode tree file feh

    mc 
    ranger 
    keepassxc

    # Tools 
    xfce.xfce4-screenshooter
    xfce.xfce4-power-manager
        
    # bindsym $mod+c exec "CM_ONESHOT=1 clipmenud"
    # bindsym $mod+v exec clipmenu
    clipmenu

    # X apps
    # chromium
    (writeShellScriptBin "chromium" ''
      ${unstable.chromium}/bin/chromium \
      --force-dark-mode \
      --start-maximized \
      $@
    '')
  ];
}