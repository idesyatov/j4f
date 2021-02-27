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

      ".config/i3blocks".source = pkgs.fetchFromGitHub {
        owner = "vivien";
        repo = "i3blocks-contrib";
        rev = "19ef961";
        sha256 = "1mwgznscxl10r5p9355yb8zixkkc7vxr3r337zmyia8ssvzvrba5";
      };

      ".xinitrc".source = ./configs/dotfiles/.xinitrc;
    };
  };
}