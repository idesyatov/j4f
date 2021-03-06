{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz";
  };
in {
  imports = [ "${home-manager}/nixos" ];

  home-manager.useUserPackages = true;

  home-manager.users.root = {
    home.file.".xinitrc".source = ./home/dotfiles/.xinitrc;
  };

  home-manager.users.morph = {
    home.file = {

      "Dev" = {
        source = ./home/Dev;
        recursive = true;
      };
    };
  };
}