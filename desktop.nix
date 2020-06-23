# Desktop env
{ config, pkgs, ...}:

let
  nonfree = import <nixos> { config.allowUnfree = true; };  
in {
  # Enable the X11 windowing system with i3wm 
  services.xserver = {
    enable = true;
    layout = "us";

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

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        networkmanagerapplet
        i3status i3lock i3blocks
      ];
    };
  };
  
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
        anonymousPro
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