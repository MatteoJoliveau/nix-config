{ config, pkgs, lib, home-manager, nixos-hardware, ... }:

{
  imports =
    [
      ../modules/base.nix
      ../modules/bluetooth.nix
      ../modules/docker.nix
      ../modules/fingerprint.nix
      ../modules/gnome.nix
      ../modules/games.nix
      ../modules/kernel.nix
      ../modules/networking.nix
      ../modules/power-management.nix
      ../modules/sound.nix
      ../modules/users
      ../modules/users/matteo.nix
      ../modules/virtualization.nix
      ./hardware-configuration.nix
      nixos-hardware.nixosModules.dell-xps-15-9500-nvidia
    ];

  system.stateVersion = "22.11";
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

  # temporary
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  # Generate an immutable /etc/resolv.conf from the nameserver settings
  # above (otherwise DHCP overwrites it):
  environment.etc."resolv.conf" = with lib; with pkgs; {
    source = writeText "resolv.conf" ''
      ${concatStringsSep "\n" (map (ns: "nameserver ${ns}") config.networking.nameservers)}
      options edns0
    '';
  };
}
