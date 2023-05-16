{ config, pkgs, lib, home-manager, nixos-hardware, ... }:

{
  imports =
    [
      ../modules/base.nix
      ../modules/docker.nix
      ../modules/games.nix
      ../modules/kernel.nix
      ../modules/networking.nix
      ../modules/sound.nix
      ../modules/users
      ../modules/users/matteo.nix
      ../modules/virtualization.nix
      ./hardware-configuration.nix
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
      nixos-hardware.nixosModules.common-pc-ssd
    ];

  system.stateVersion = "22.11";
  networking.hostName = "microwave";
}
