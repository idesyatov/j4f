# Desktop env
{ config, pkgs, ...}:

let
  nonfree = import <nixos> { config.allowUnfree = true; };  
in {
  environment.pathsToLink = [ "/libexec" ];

  # Enable the X11 windowing system with i3wm 
  services.xserver = {
    enable = true;
    layout = "us,ru";

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

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

        ''}"
    '';

    # i3wm settings
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        networkmanagerapplet
        i3status i3lock i3blocks
      ];
      
      # i3 CONFIG
      config = {
        modifier = "Mod4";
        fonts = [ "pango:monospace 8" ];

        keybindings = let mod = config.xsession.windowManager.i3.config.modifier; in lib.mkOptionDefault {
          "${mod}+q" = "kill";
          
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${mod}+r" = "mode resize";

          "${mod}+f" = "fullscreen toggle";
          "${mod}+Shift+space" = "floating toggle";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          "${mod}+v" = "split v";
          "${mod}+h" = "split h";

          "${mod}+1" = "workspace 1";
          "${mod}+2" = "workspace 2";
          "${mod}+3" = "workspace 3";
          "${mod}+4" = "workspace 4";
          "${mod}+5" = "workspace 5";
          "${mod}+6" = "workspace 6";
          "${mod}+7" = "workspace 7";
          "${mod}+8" = "workspace 8";
          "${mod}+9" = "workspace 9";
          "${mod}+0" = "workspace 10";

          "${mod}+Shift+1" = "move container to workspace 1";
          "${mod}+Shift+2" = "move container to workspace 2";
          "${mod}+Shift+3" = "move container to workspace 3";
          "${mod}+Shift+4" = "move container to workspace 4";
          "${mod}+Shift+5" = "move container to workspace 5";
          "${mod}+Shift+6" = "move container to workspace 6";
          "${mod}+Shift+7" = "move container to workspace 7";
          "${mod}+Shift+8" = "move container to workspace 8";
          "${mod}+Shift+9" = "move container to workspace 9";
          "${mod}+Shift+0" = "move container to workspace 10";

          # brightness
          XF86MonBrightnessDown = "exec ${pkgs.brightnessctl}/bin/brightnessctl -q s 5%-";
          XF86MonBrightnessUp = "exec ${pkgs.brightnessctl}/bin/brightnessctl -q s 5%+";

          # volume
          XF86AudioRaiseVolume = "exec ${pkgs.ponymix}/bin/ponymix increase 5";
          XF86AudioLowerVolume = "exec ${pkgs.ponymix}/bin/ponymix decrease 5";
          XF86AudioMute = "exec ${pkgs.ponymix}/bin/ponymix toggle";

          # media
          XF86AudioPlay = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          XF86AudioPause = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          XF86AudioNext = "exec ${pkgs.playerctl}/bin/playerctl next";
          XF86AudioPrev = "exec ${pkgs.playerctl}/bin/playerctl previous";
        };
      };
    };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
        ubuntu_font_family
        noto-fonts-emoji
        cantarell_fonts
        cm_unicode
        google-fonts
        go-font
        cm_unicode

        nonfree.corefonts
    ];
  };
  
  # sound.enable = true;
  # services.blueman.enable = true; 
  
  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere
      "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
      "aapbdbdomjkkjkaonfhkkikfgjllcleb" # Google Translate
      "naepdomgkenhinolocfifgehidddafch" # Browserpass
      "fihnjjcciajhdojfnbdddfaoknhalnja" # I don't care about cookies
      "kbfnbcaeplbcioakkpcpgfkobkghlhen" # Grammarly
    ];
    extraOpts = {
      DefaultBrowserSettingEnabled = true;

      TranslateEnabled = false;
      SpellcheckEnabled = false;
      SpellCheckServiceEnabled = false;
      PrintingEnabled = false;
      SearchSuggestEnabled = false;
      PasswordManagerEnabled = false;
      SafeBrowsingEnabled  = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      MetricsReportingEnabled = false;
      BuiltInDnsClientEnabled = false;
      EnableMediaRouter = false;
      PromotionalTabsEnabled = false;

      SyncDisabled = true;

      SigninAllowed = false;
      AudioCaptureAllowed = false;
      VideoCaptureAllowed = false;
      SSLErrorOverrideAllowed = false;
      AutoplayAllowed = false;

      # 0 = Disable browser sign-in
      BrowserSignin = 0;

      DefaultSearchProviderEnabled = true;
      DefaultSearchProviderSearchURL = "https://duckduckgo.com/"
        + "?kae=d&k1=-1&kc=1&kav=1&kd=-1&kh=1&q={searchTerms}";

      # Do not allow any site to show desktop notifications
      DefaultNotificationsSetting = 2;
      # Do not allow any site to track the users' physical location
      DefaultGeolocationSetting = 2;
      # Block the Flash plugin
      DefaultPluginsSetting = 2;
    };
  };
}