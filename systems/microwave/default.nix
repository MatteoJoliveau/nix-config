{
  config,
  pkgs,
  lib,
  home-manager,
  nixos-hardware,
  ...
}:

{
  imports = [
    ../modules/base.nix
    ../modules/docker.nix
    ../modules/games.nix
    ../modules/kernel.nix
    ../modules/networking.nix
    ../modules/plasma6.nix
    ../modules/sound.nix
    ../modules/users
    ../modules/users/matteo.nix
    ../modules/virtualization.nix
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  users.users.matteo.initialPassword = "test";
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192;
      cores = 2;
    };
  };

  system.stateVersion = "23.05";
  networking.hostName = "microwave";
}
