# Reproducible localhost

[Download NixOS installation ISO](https://nixos.org/nixos/download.html)

## Installation

    parted /dev/sda mklabel gpt
    parted /dev/sda mkpart EFI fat32 0% 512M
    parted /dev/sda set 1 esp on
    parted /dev/sda mkpart NIX ext4 512M 100%

    cryptsetup luksFormat /dev/sda2
    cryptsetup open /dev/sda2 nix

    mkfs.vfat -F32 /dev/sda1
    mkfs.ext4 /dev/mapper/nix

    mount /dev/mapper/nix /mnt/
    mkdir /mnt/boot
    mount /dev/sda1 /mnt/boot

    nix-env -iA nixos.gitMinimal
    git clone https://github.com/idesyatov/j4f.git /mnt/etc/nixos/

    nix-channel --add https://nixos.org/channels/nixos-20.09 nixos
    nix-channel --add https://nixos.org/channels/nixos-20.09-small nixos-small
    nix-channel --update

    nixos-generate-config --root /mnt

    nixos-install
    reboot

## After install

Login as `root` with the password specified during installation

Set passwd for `user` from configuration.nix.

    sudo nix-channel --add https://nixos.org/channels/nixos-20.09 nixos
    sudo nix-channel --add https://nixos.org/channels/nixos-20.09-small nixos-small
    sudo nix-channel --update
