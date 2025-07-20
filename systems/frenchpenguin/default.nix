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
    ../modules/bluetooth.nix
    ../modules/cloudflare-warp.nix
    ../modules/docker.nix
    ../modules/fingerprint.nix
    ../modules/hyprland.nix
    ../modules/games.nix
    ../modules/gnome-keyring.nix
    ../modules/kernel.nix
    ../modules/networking.nix
    ../modules/power-management.nix
    ../modules/sound.nix
    ../modules/users
    ../modules/users/matteo.nix
    ../modules/virtualization.nix
    ../modules/wireguard.nix
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.lenovo-thinkpad
    nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  system.stateVersion = "23.05";
  networking.hostName = "frenchpenguin";

  hardware.opengl = {
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };

  # Enable Thunderbolt
  services.hardware.bolt.enable = true;

  services.throttled.enable = true;

  networking.firewall = {
    allowedTCPPorts = [
      19000 # Expo mobile app
    ];
  };
}
