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