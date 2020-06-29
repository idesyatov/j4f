{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.lightline-vim
      pkgs.vimPlugins.gitgutter
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.vim-unimpaired
      pkgs.vimPlugins.youcompleteme
      pkgs.vimPlugins.nord-vim
    ];
    settings = {
      ignorecase = true;
      mouse = "a";
      number = true;
      relativenumber = true;
    };
  };
}