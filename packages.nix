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
    
    # VIM Config
    ((vim_configurable.override { python = python3; }).customize{
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [
          nerdtree 
          vim-nix 
          vim-lastplace 
        ];
        opt = [];
      };
      vimrcConfig.customRC = ''
        "# Settings 
        syntax on

        "# set number
        set relativenumber

        set paste
        set wildmenu
        set smarttab
        set showmatch

        set t_Co=256
        set background=dark
        colorscheme elflord 

        "# Tab 4 chars, hotkeys 'c - t' ->, 'c - d' <- 
        set tabstop=4 softtabstop=-1 shiftwidth=0 expandtab
        set backspace=indent,eol,start

        "# Search hightlight 
        set hlsearch
        set incsearch

        "# Buffer
        set clipboard=unnamedplus 

        "###  Pluggin settings ###

        "# NerdTree
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
    picom 
    xautolock
    xfce.xfce4-screenshooter
    xfce.xfce4-power-manager

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