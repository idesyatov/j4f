# Software env
{ config, pkgs, ...}:

let
  nonfree = import <nixos> { config.allowUnfree = true; };
in {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  imports =
  [
    ./nix/zsh.nix
    ./nix/chromium.nix
  ];

  #environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    
    ((vim_configurable.override { python = python3; }).customize{
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace ];
        opt = [];
      };
      vimrcConfig.customRC = ''
        "# Settings 
        syntax on

        "# set number
        set relativenumber

        set wildmenu
        set smarttab
        set showmatch

        set t_Co=256
        set background=dark
        colorscheme elflord 

        "# Tab 4 chars, hotkeys 'c - t' ->, 'c - d' <- 
        set tabstop=4 softtabstop=-1 shiftwidth=0 expandtab

        "# Search hightlight 
        set hlsearch
        set incsearch

        "# Buffer
        set clipboard=unnamedplus 

        "###  Pluggin settings ###

        "# NerdTree
        "autocmd vimenter * NERDTree
        map <C-n> :NERDTreeToggle<CR>
      '';
    })

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
      ${chromium}/bin/chromium \
      --force-dark-mode \
      --start-maximized \
      $@
    '')
  ];
}