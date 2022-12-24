{ pkgs, ... }:

let
  pano = import ../overlays/gnome-pano;
in
{
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.tiling-assistant
    gnomeExtensions.pano
    gnomeExtensions.mpris-indicator-button
    gnome.gnome-tweaks
  ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  nixpkgs.overlays = [
    pano
  ];
}
