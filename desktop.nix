# Desktop env
{ lib, config, pkgs, ...}:

let
  nonfree = import <nixos> { config.allowUnfree = true; };  
in {
  environment.pathsToLink = [ "/libexec" ];

  ## Enable the X11 windowing system with i3wm 
  services.xserver = {
    enable = true;

    resolutions = [
      { x = 1280; y = 720; }
      { x = 1920; y = 1080; }
      { x = 2560; y = 1440; }
    ];

    layout = "us,ru";

    desktopManager.xterm.enable = false;

    displayManager.lightdm = {
      enable = true;
      background = pkgs.nixos-artwork.wallpapers.dracula.gnomeFilePath;
      greeters = {
        gtk = {
          enable = true;
          clock-format = "%a %d/%m %H:%M:%S";
          iconTheme = {
            package = pkgs.arc-icon-theme;
            name = "Arc";
          };
          indicators = [ "~clock" "~session" "~power" ];
          theme = {
            package = pkgs.arc-theme;
            name = "Arc-Dark";
          };
        };
      };
    };

    displayManager.defaultSession = "none+i3";
    displayManager.sessionCommands =  ''
        xrdb "${pkgs.writeText  "xrdb.conf" ''
          
          URxvt.font:               xft:ubuntu mono:pixelsize=18
          
          urxvt*termName:           rxvt
          urxvt*scrollBar:          false
          urxvt.transparent:        false
          urxvt*matcher.button:     1
          urxvt.boldFont:
          
          Xft*dpi:                  96
          Xft*antialias:            true
          Xft*hinting:              true
          Xft*hintstyle:            hintfull
          Xft*rgba: rgb
          *internalBorder:          13
          
          URxvt*geometry:           85x20
          URxvt*fading:             0
          URxvt*shading:            0
          URxvt*inheritPixmap:      False
          
          URxvt*tintColor:          #ffffff
          URxvt*background:         #273240
          URxvt*foreground:         #C2B0AE
          
          URxvt.color0:             #2E3436
          URxvt.color1:             #CC0000
          URxvt.color2:             #4E9A06
          URxvt.color3:             #C4A000
          URxvt.color4:             #3465A4
          URxvt.color5:             #75507B
          URxvt.color6:             #06989A
          URxvt.color7:             #D3D7CF
          URxvt.color8:             #555753
          URxvt.color9:             #EF2929
          URxvt.color10:            #8AE234
          URxvt.color11:            #FCE94F
          URxvt.color12:            #729FCF
          URxvt.color13:            #AD7FA8
          URxvt.color14:            #34E2E2
          URxvt.color15:            #EEEEEC

          URxvt.keysym.Control-Up:     \033[1;5A
          URxvt.keysym.Control-Down:   \033[1;5B
          URxvt.keysym.Control-Left:   \033[1;5D
          URxvt.keysym.Control-Right:  \033[1;5C

        ''}"
    '';

    ## i3wm settings 
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status i3lock 
      ];
      configFile = import ./home/i3config.nix { inherit config; inherit pkgs; };
    };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
        ubuntu_font_family
        noto-fonts
        noto-fonts-extra
        noto-fonts-emoji
        font-awesome

        nonfree.corefonts
    ];
  };
  
  # Bluetooth applet
  #services.blueman.enable = true; 
  
  # Enable touchpad support.
  #services.xserver.libinput.enable = true;

  # Network-manager applet
  programs.nm-applet.enable = true;
}