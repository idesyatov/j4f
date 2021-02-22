{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz";
  };
in {
  imports = [ "${home-manager}/nixos" ];

  home-manager.useUserPackages = true;

  home-manager.users.morph = {
    home.file = {
      ".xinitrc".source = ./configs/dotfiles/.xinitrc;
    };
  };
}