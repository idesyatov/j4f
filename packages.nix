# Software env
{ config, pkgs, ...}:

let
  nonfree = import <nixos> { config.allowUnfree = true; };
  unstable = import <unstable> {};
  unstable-nonfree = import <unstable> { config.allowUnfree = true; };
in {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    
    # Utils
    vim git htop tmux wget tldr
    rxvt_unicode tree ranger file feh
        
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